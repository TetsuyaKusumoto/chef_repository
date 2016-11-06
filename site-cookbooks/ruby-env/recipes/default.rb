#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install openssl-devel and sqlite-devel
%w{readline-devel openssl-devel sqlite-devel}.each do |pkg|
  # packageはインストール。このpackageとかgitをresourceという。
  package pkg do
    action :install
  end
end

# rbenv
#git "/home/#{node['ruby-env']['user']}/.rbenv" do
#  repository node['ruby-env']['rbenv_url']
#  action :sync
#  user  node['ruby-env']['user']
#  group node['ruby-env']['group']
#end

# rbenv
git "#{node['ruby-env']['install_path']}/rbenv" do
  repository node['ruby-env']['rbenv_url']
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end


#template ".bash_profile" do
#  source ".bash_profile.erb"
#  path   "/home/#{node['ruby-env']['user']}/.bash_profile"
#  mode   0655
#  owner  node['ruby-env']['user']
#  group  node['ruby-env']['group']
#  not_if "grep rbenv ~/.bash_profile", environment: { :'HOME' => "/home/#{node['ruby-env']['user']}" }
#end

#template ".bash_profile" do
#  source ".bash_profile.erb"
#  path   "/home/#{node['ruby-env']['user']}/.bash_profile"
#  path "/home/deploy/.bash_profile"
#  mode   0655
#  owner  node['ruby-env']['user']
#  group  node['ruby-env']['group']
#  not_if "grep rbenv ~/.bash_profile", environment: { :'HOME' => "/home/deploy" }
#end

# ruby
directory "#{node['ruby-env']['install_path']}/rbenv/plugins" do
  mode   0755
  owner  node['ruby-env']['user']
  group  node['ruby-env']['group']
  action :create
end

# ruby-build
git "#{node['ruby-env']['install_path']}/rbenv/plugins/ruby-build" do
  repository node['ruby-env']['ruby-build_url']
  action :sync
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
end

template "rbenv.sh" do
    path "/etc/profile.d/rbenv.sh"
    owner "root"
    group "root"
    mode "0644"
    source "rbenv.sh.erb"
end

# install ruby
execute "rbenv install #{node['ruby-env']['version']}" do
  command "source /etc/profile.d/rbenv.sh; rbenv install #{node['ruby-env']['version']}"
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
  #environment 'HOME' => "/home/#{node['ruby-env']['user']}"
  not_if { File.exists?("#{node['ruby-env']['install_path']}/rbenv/versions/#{node['ruby-env']['version']}") }
end

# set rbenv global
execute "rbenv global #{node['ruby-env']['version']}" do
  command "source /etc/profile.d/rbenv.sh; rbenv global #{node['ruby-env']['version']}"
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
  #environment 'HOME' => "/home/#{node['ruby-env']['user']}"
end

# install rbenv-rehash and bundler gem
%w{rbenv-rehash bundler}.each do |gem_name|
  execute "gem install #{gem_name}" do
    command "source /etc/profile.d/rbenv.sh; gem install #{gem_name}"
    user   node['ruby-env']['user']
    group  node['ruby-env']['group']
    #environment 'HOME' => "/home/#{node['ruby-env']['user']}"
    # すでにインストールリストになければ
    not_if "#{node['ruby-env']['install_path']}/rbenv/shims/gem list | grep #{gem_name}"
  end
end
