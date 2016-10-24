#
# Cookbook Name:: init_script
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

puma_app_service = "puma_#{node.set['project']['name']}"
 
template "/etc/init.d/#{puma_app_service}" do
  source "puma_app.erb"
  owner 'root'
  group 'root'
  mode "0755"
end
 
bash "add_puma_app_service" do
  not_if "chkconfig --list | grep #{puma_app_service} | grep 3:on"
  code <<-EOC
    chkconfig --add #{puma_app_service}
    chkconfig #{puma_app_service} on
  EOC
end
