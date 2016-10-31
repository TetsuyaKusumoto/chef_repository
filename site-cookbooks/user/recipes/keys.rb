include_recipe "user::deploy_user"

directory "/home/deploy/.ssh" do
  action :create
  owner "deploy"
  mode "0700"
end

cookbook_file "/home/deploy/.ssh/id_rsa" do
  action :create
  owner "deploy"
  mode "0600"
end

cookbook_file "/home/deploy/.ssh/authorized_keys" do
  action :create
  owner "deploy"
  mode "0600"
end
