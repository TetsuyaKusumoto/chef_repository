#
# Cookbook Name:: user
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group 'deploy' do
  group_name "deploy"
  action     [:create]
end

user 'deploy' do
  comment  "deploy user"
  group    "deploy"
  home     "/home/deploy"
  supports :manage_home => true
  action   [:create, :manage]
  shell "/bin/bash"
end
