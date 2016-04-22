## hombros default
## set up Jenkins server
#node.default['jenkins']['master']["install_method"]='package'
##node.default['jenkins']['master']["version"]='1.651.1_all'
#node.default['jenkins']['master']["version"]='1.651'
#include_recipe "jenkins::master"
##package 'jenkins' do
   #version "1.651.1_all"
#end

remote_file "/jenkins_1.509.1_all.deb" do
   source "http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_1.509.1_all.deb"
end

execute 'isntall jenkins' do
  command 'dpkg --force-confdef --force-confold -i /jenkins_1.509.1_all.deb'
end

service 'jenkins' do
   action :start
end

directory "/var/lib/jenkins/.ssh"  do
  mode 00755
  action :create
  recursive true
end

execute 'duplicate keys' do
  cwd '/home/vagrant/shared/keys'
  command 'cp * /var/lib/jenkins/.ssh'   # this includes authorized_keys, don't think it does any good there
end

execute 'correct Jenkins directory ownership' do
  command 'chown -R jenkins /var/lib/jenkins &&  \
          chgrp -R jenkins /var/lib/jenkins'
end

privkey = File.read("/mnt/shared/keys/id_rsa")

jenkins_private_key_credentials 'jenkins' do
  id '1ea894fc-d69e-4f2e-ba27-30bf66f774b3'  # generated this once upon a time. recommend you generate a new one.
  description 'SSH key'
  private_key privkey
end

# create slave
jenkins_ssh_slave 'brazos' do
  description 'Run test suites'
  remote_fs   '/home/jenkins'
  #labels      ['executor', 'freebsd', 'jail']

  # SSH specific attributes
  host        'brazos' # or 'slave.example.org'
  user        'jenkins'
  credentials 'jenkins'
end

#ESSENTIAL - set master to 0 executors


#jenkins_plugin 'git-client' do
#  action :uninstall
#end

jenkins_plugin 'git' do   #install git plugin
  #action :uninstall
  notifies :restart, 'service[jenkins]', :immediately
end

jenkins_plugin 'artifactory' do   #install artifactory plugin
  #action :uninstall
  notifies :restart, 'service[jenkins]', :immediately
end


cookbook_file "hijoInit.xml" do    # downloaded from manually defined job. todo: convert this to erb file
  path "#{Chef::Config[:file_cache_path]}/hijoInit.xml"
  mode 0744
end

xml = File.join(Chef::Config[:file_cache_path], 'hijoInit.xml')

jenkins_job 'hijoInit' do
  config xml
end

file_map = {
  "hijoConfig.xml" => "/var/lib/jenkins/jobs/hijoInit/config.xml",
 "org.jfrog.hudson.ArtifactoryBuilder.xml" => "/var/lib/jenkins/org.jfrog.hudson.ArtifactoryBuilder.xml"
}

# download each file and place it in right directory
file_map.each do | fileName, pathName |
  cookbook_file fileName do
    path pathName
    user "jenkins"
    group "jenkins"
    action :create
  end
end

jenkins_command 'safe-restart'

#For docker phusion images to work
file "/etc/my_init.d/tomcat6" do
  content "#!/bin/bash
export PATH=/usr/lib/jvm/java-7-openjdk-amd64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
/etc/init.d/jenkins start

"
  mode '0755'
end


# project name hijoInit
