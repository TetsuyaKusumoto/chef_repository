#
# Cookbook Name:: custom-td-agent
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"
include_recipe "td-agent"

template "rails.conf" do
  path	"/etc/td-agent/conf.d/rails.conf"
  source "rails.conf.erb"
  mode 0644
  user "root"
  group "root"
end
