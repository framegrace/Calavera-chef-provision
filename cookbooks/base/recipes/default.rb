# base configuration.
# this needs to be then re-packaged to minimize virtual machine loading time while constructing the various nodes

#execute 'apt update' do
  #command 'apt-get -q update'   
#end
execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  #only_if do
    #File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    #File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  #end
end


#include_recipe "java7::default"
include_recipe "curl::default"

#execute 'install tree' do
  #command 'apt-get -q install tree'   
#end
execute "ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa" do
     creates "/etc/ssh/ssh_host_dsa_key" 
end
execute "ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa" do
     creates "/etc/ssh/ssh_host_rsa_key" 
end
execute "cp /home/vagrant/shared/keys/id_rsa.pub /root/.ssh/authorized_keys" do
     creates "/root/.ssh/authorized_keys" 
end

file "/etc/my_init.d/ssh" do
  content "#!/bin/bash
export PATH=/usr/lib/jvm/java-7-openjdk-amd64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
/etc/init.d/ssh start

"
  mode '0755'
end

