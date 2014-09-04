#
# Cookbook Name:: apache_kafka
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
KAFKA_VERSION = node['apache_kafka']['kafka_version']
SCALA_VERSION = node['apache_kafka']['scala_version']
REMOTE_URL = node['apache_kafka']['remote_url']
INSTALL_USER = node['apache_kafka']['install_user']
INSTALL_DIR = node['apache_kafka']['install_dir']
KAFKA_SERVER = node['apache_kafka']['kafka_server']
ZOOKEEPER_SERVER = node['apache_kafka']['zookeeper_server']
ZOOKEEPER_PORT = node['apache_kafka']['zookeeper_port']

BASENAME = "kafka_#{SCALA_VERSION}-#{KAFKA_VERSION}"
FILENAME = "#{BASENAME}.tgz"

KAFKA_CONFIG_FILE = "#{INSTALL_DIR}/#{BASENAME}/config/server.properties"

ZOOKEEPER_KEY = "zookeeper.connect"
KAFKA_KEY = "host.name"

bash "rewrite_server_properties" do
  user "#{INSTALL_USER}"
  code <<-EOS
  sed -i.org -e 's/^#{ZOOKEEPER_KEY}=.*/#&/' #{KAFKA_CONFIG_FILE}
  echo #{ZOOKEEPER_KEY}=#{ZOOKEEPER_SERVER}:#{ZOOKEEPER_PORT} >> #{KAFKA_CONFIG_FILE}
  echo #{KAFKA_KEY}=#{KAFKA_SERVER} >> #{KAFKA_CONFIG_FILE}
  EOS
  action :nothing
end
bash "install_kafka" do
  user "#{INSTALL_USER}"
  code <<-EOS
  tar xvzf /tmp/#{FILENAME} -C #{INSTALL_DIR}
  EOS
  action :nothing
  notifies :run , resources( :bash => "rewrite_server_properties" )
end
remote_file "/tmp/#{FILENAME}" do
  not_if { File.exists? "#{INSTALL_DIR}/#{BASENAME}" }

  source "#{REMOTE_URL}/#{KAFKA_VERSION}/#{FILENAME}"
  action :create
  notifies :run , resources( :bash => "install_kafka" )
end

