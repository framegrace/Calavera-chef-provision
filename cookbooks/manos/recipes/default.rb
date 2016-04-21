# manos-default

# set up developer workstation

# assuming Chef has set up Java, Tomcat, ant and junit
# need to establish directory structure
# move source code over
# run Ant # OR... have Jenkins do? Or do manually? 
# remote push Git?


#execute "apt-get-update-periodic" do
  #command "apt-get update"
  #ignore_failure true
  ##only_if do
    ##File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    ##File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  ##end
#end

package 'git'
package 'tomcat6'
#For docker phusion images to work
file "/etc/my_init.d/tomcat6" do
  content "#!/bin/bash
export PATH=/usr/lib/jvm/java-7-openjdk-amd64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
/etc/init.d/tomcat6 start || exit 0

"
  mode '0755'
end


package "tree"

group 'git'
group 'vagrant'

user 'vagrant' do
  group 'git'
  password '*'
end

user 'hijo' do
  group 'git'
  password '*'
end

["/home/hijo/src/main/config",
 "/home/hijo/src/main/java/biz/calavera", 
 "/home/hijo/src/test/java/biz/calavera",
 "/home/hijo/target/biz/calavera",
 "/home/hijo/.ssh"].each do | name |

  directory name  do
    mode 00775
    action :create
    user "hijo"
    group "git"
    recursive true
  end
end

file_map = {
  "INTERNAL_gitignore" => "/home/hijo/.gitignore",
 "build.xml" => "/home/hijo/build.xml",
 "web.xml" => "/home/hijo/src/main/config/web.xml", 
 "Class1.java" => "/home/hijo/src/main/java/biz/calavera/Class1.java",
 "MainServlet.java" =>  "/home/hijo/src/main/java/biz/calavera/MainServlet.java",
 "TestClass1.java" => "/home/hijo/src/test/java/biz/calavera/TestClass1.java"
}

# download each file and place it in right directory
file_map.each do | fileName, pathName |
  cookbook_file fileName do
    path pathName
    user "hijo"
    group "git"
    action :create
  end
end

cookbook_file '/etc/sudoers.d/hijo' do
  source 'vagrant_sudo'
  mode 600
  user 'root'
  group 'root'
  action :create
end

execute 'correct dev directory permissions' do
  command 'chown -R hijo /home/hijo/ && chgrp -R git /home/hijo/'          # Chef does not have an easy way to do this. 
end

execute 'correct tomcat webapps permissions' do
  command   'chown -R hijo /var/lib/tomcat6/webapps/ && chgrp -R vagrant /var/lib/tomcat6/webapps/'    #
end

execute 'initial build & dev deploy' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  command 'ant'
end

execute 'initialize git 1' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'git config --global user.email "char@calavera.biz"'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 2' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'git config --global user.name "Charles Betz"'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 3' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'git init /home/hijo'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 4' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'git add .'   # needs to be idempotent
end

execute 'initialize git 5' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  ignore_failure true
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'git commit -m "initial commit"'   # needs to be idempotent
end

execute 'register server' do
  user "hijo"
  group "git"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'ssh-keyscan cerebro >> ~/.ssh/known_hosts'   # prevents interactive dialog
end

execute 'define remote' do
  user "hijo"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  command 'git remote add origin ssh://cerebro/home/hijo.git'   # define master git server. high priority to make idempotent.
end


# Let's do that on run time
#execute 'push to remote' do
  #user "hijo"
  #cwd '/home/hijo'
  #environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  #command 'git push origin --mirror'   # erase master - if rebuilding manos, assume this is desired. may want to reconsider.
#end

#execute 'push to remote' do
  #user "hijo"
  #cwd '/home/hijo'
  #environment ({'HOME' => '/home/hijo', 'USER' => 'hijo'})  
  #command 'git push origin master'   # push to master git server
#end



