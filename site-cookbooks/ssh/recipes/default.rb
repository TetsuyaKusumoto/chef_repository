#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
service "sshd" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
end
 
template "sshd_config" do
    path "/etc/ssh/sshd_config"
    source "sshd_config.erb"
    mode 0600
    notifies :reload, "service[sshd]"
end
 
template "i18n" do
    path "/etc/sysconfig/i18n"
    source "i18n.erb"
    mode 0644
end


