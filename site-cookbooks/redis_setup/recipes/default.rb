#
# Cookbook Name:: redis_setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
REDIS_SERVER = node['redis_setup']['redis_server']

REDIS_CONFIG_FILE = "/etc/redis/redis.conf"

bash "rewite_redis_properties" do
  only_if { File.exists? "#{REDIS_CONFIG_FILE}" }

  user "root"
  code <<-EOS
  sed -i.org -e 's/^bind .*/#&/' #{REDIS_CONFIG_FILE}
  echo 'bind #{REDIS_SERVER}' >> #{REDIS_CONFIG_FILE}
  /etc/init.d/redis-server restart
  EOS
  action :run
end

