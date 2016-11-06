#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum-epel"

# install
package "nginx" do
  action :install
end
  
# serviceはサービスを操作するリソース
# A service resource block manages the state of a service.
service "nginx" do
  action    [ :enable, :start ]
  supports  :status => true, :restart => true, :reload => true
end
  
# templateは設定ファイル
template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 644
  notifies :restart, 'service[nginx]'
end
# このように複数のファイルを指定もできる。ただし、templateファイル（erbはその分を用意する）

template 'nginx.repo' do
  path    '/etc/yum.repos.d/nginx.repo'
  source  'nginx.repo.erb'
  mode    0644
  user    'root'
  group   'root'
  action :create
end

directory '/etc/nginx/sites-available' do
  owner 'root'
  group 'root'
  mode 0644
  recursive true
end

directory '/etc/nginx/sites-enabled' do
  owner 'root'
  group 'root'
  mode 0644
  recursive true
end


template 'default' do
  path    '/etc/nginx/sites-available/default'
  source  'default.erb'
  mode    0644
  user    'root'
  group   'root'
end

template 'sample-app' do
  path    '/etc/nginx/sites-available/sample-app'
  source  'sample-app.erb'
  mode    0644
  user    'root'
  group   'root'
end

