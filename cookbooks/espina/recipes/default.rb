
#artifactory
# get from http://bit.ly/Hqvfi9  (the zip file. use unzip.)

#create users


group 'artifactory'

user 'artifactory' do
  group 'artifactory'
  password '*'
end

#remote_file "/opt/artifactory-latest.zip" do
#  source "http://bit.ly/Hqv9aj"    # this was being stubborn with full URL for some reason. points to latest build. 
#  mode '0755'
#end

# Pointing to the latest is a bad idea (Latest doesn't work with java7)
# Using 3.5.1
remote_file "/opt/artifactory-3.5.1.zip" do
  source "http://downloads.sourceforge.net/project/artifactory/artifactory/3.5.1/artifactory-3.5.1.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fartifactory%2Ffiles%2Fartifactory%2F3.5.1%2F&ts=1442352878&use_mirror=kent"    # this was being stubborn with full URL for some reason. points to latest build. 
  mode '0755'
  checksum 'b6ae87d5ce044975af9965ac833c91e9c64b9ece3ececb59007a3c33749367e4'
  notifies :run, 'execute[unzip]', :immediate
end

#cookbook_file 'artifactory-3.5.1.zip' do
#    path '/opt/artifactory-3.5.1.zip'
#    action :create
#end

execute 'unzip' do   # make idempotent
  user 'root'
  cwd '/opt'
  command 'jar -xvf /opt/artifactory-3.5.1.zip' 
  action :nothing
end

link '/opt/artifactory-latest' do
   to '/opt/artifactory-3.5.1'
end

execute 'correct artifactory directory permissions' do
  command 'chown -R artifactory /opt/artifactory-latest/ && chgrp -R artifactory /opt/artifactory-latest/'          # Chef does not have an easy way to do this.
end

execute 'correct executables' do
  command 'chmod 755 /opt/artifactory-latest/bin/*'       # Chef does not have an easy way to do this.
end

execute 'install Artifactory service' do
  user 'root'
  command '/opt/artifactory-latest/bin/installService.sh'       # Start Artifactory. Need to install as a service that auto-restarts.  
end

service 'artifactory' do
  action [ :enable, :start ]
end


#For docker phusion images to work
file "/etc/my_init.d/artifactory" do
  content "#!/bin/bash
export PATH=/usr/lib/jvm/java-7-openjdk-amd64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
/etc/init.d/artifactory start

"
  mode '0755'
end

# unzip to /opt (cd, chmod, etc)
