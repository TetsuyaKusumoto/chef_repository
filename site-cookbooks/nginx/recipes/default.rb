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
end
