#
# Cookbook Name:: rails_env
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory '/var/www' do
  owner 'root'
  group 'root'
  mode 0644
  recursive true
end
