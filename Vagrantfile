# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION ||= "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  kafka_addr = "192.168.33.10"
  storm_addr = "192.168.33.11"

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
  #  vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1536"]
  end

  config.vbguest.auto_update = true

  config.omnibus.chef_version = :latest
  
  config.vm.define :kafka do |kafka|
    kafka.vm.network :private_network, ip: kafka_addr, virtualbox__intnet: "intnet"
    kafka.vm.network :forwarded_port, guest: 2181, host: 2181
    kafka.vm.network :forwarded_port, guest: 9092, host: 9092

    kafka.vm.provision "chef_solo" do |chef|
      chef.log_level = :debug
      chef.cookbooks_path = ["./cookbooks"]
      chef.add_recipe "apt"
      chef.add_recipe "git"
      chef.add_recipe "hosts_setup"
      chef.add_recipe "java"
      chef.add_recipe "apache_kafka"
   
      # You may also specify custom JSON attributes:
      chef.json = {
        "java" => {
          "install_flavor" => "oracle",
          "jdk_version" => 8,
          "oracle" => {
            "accept_oracle_download_terms" => true
          }
        },
        "hosts_setup" => {
          "entries" => {
            "zookeeper" => kafka_addr,
            "kafka" => kafka_addr,
            "storm" => storm_addr
          }
        },
        "apache_kafka" => {
          "scala_version" => "2.10",
          "kafka_version" => "0.8.1.1",
          "install_user" => "vagrant",
          "install_dir" => "/home/vagrant",
          "kafka_server" => "kafka",
          "zookeeper_server" => "zookeeper",
          "zookeeper_port" => "2181"
        }
      }
    end
  end

  config.vm.define :storm do |storm|
    storm.vm.network :private_network, ip: "192.168.33.11", virtualbox__intnet: "intnet"
    storm.vm.provision "chef_solo" do |chef|
      chef.log_level = :debug
      chef.cookbooks_path = ["./cookbooks"]
      chef.add_recipe "apt"
      chef.add_recipe "git"
      chef.add_recipe "redis::install"
      chef.add_recipe "hosts_setup"
      chef.add_recipe "java"
      chef.add_recipe "chef-sbt"
   
      # You may also specify custom JSON attributes:
      chef.json = {
        "java" => {
          "install_flavor" => "oracle",
          "jdk_version" => 8,
          "oracle" => {
            "accept_oracle_download_terms" => true
          }
        },
        "hosts_setup" => {
          "entries" => {
            "zookeeper" => kafka_addr,
            "kafka" => kafka_addr,
            "storm" => storm_addr
          }
        },
        "sbt" => {
          "version" => "0.13.5",
          "java_options" => "-Xms512M -Xmx1024M -Xss1M -XX:+CMSClassUnloadingEnabled -Dfile.encoding=UTF-8"
        }
      }
    end
  end
end
