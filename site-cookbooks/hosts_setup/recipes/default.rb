#
# Cookbook Name:: hosts_setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

entries = node['hosts_setup']['entries']

entries.each do |name, addr|
  hostsfile_entry addr do
    hostname name
    action :append
  end
end

