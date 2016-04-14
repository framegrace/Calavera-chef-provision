# brazos default
# set up remote slave build server
execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  #only_if do
    #File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    #File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  #end
end

package 'git'

group 'jenkins'

user 'jenkins' do
  group 'jenkins'
  password '*'
end


directory "/home/jenkins/.ssh"  do
  mode 00755
  action :create
  recursive true
end

execute 'duplicate keys' do
  cwd '/home/vagrant/shared/keys'
  command 'cp id_rsa* /home/jenkins/.ssh'   # includes authorized hosts
end

execute 'authorize jenkins public key' do
  cwd '/home/jenkins/.ssh'
  command 'cat id_rsa.pub >> authorized_keys'   # includes authorized hosts
end

execute 'correct Jenkins directory ownership' do
  command ' chown -R jenkins /home/jenkins &&  \
            chgrp -R jenkins /home/jenkins'
end

#execute 'correct tomcat webapps permissions' do
#  command   'chown -R jenkins /var/lib/tomcat6/webapps &&     \
#             chgrp -R jenkins /var/lib/tomcat6/webapps'    #
#end

# when rebuilding brazos it would be nice to let Jenkins know, if Jenkins is running.
