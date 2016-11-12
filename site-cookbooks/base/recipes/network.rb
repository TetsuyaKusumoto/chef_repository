# need to restart manually when modifying network config files
 
# config files
network_conf = "/etc/sysconfig/network"
etc_hosts = "/etc/hosts"
 
[network_conf, etc_hosts].each do |conf_file|
  conf_basename = File.basename(conf_file)
 
  bash "move_#{conf_basename}_conf_original" do
    code <<-EOC
      mv #{conf_file} #{conf_file}.org
    EOC
    creates "#{conf_file}.org"
  end
 
  template conf_file do
    owner "root"
    group "root"
    mode 0644
  end
end
 
# remove NetworkManager
#service 'NetworkManager' do
#  action [:disable, :stop]
#end
 
#package "NetworkManager" do
#  action :remove
#end
 
# start network service
service "network " do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
