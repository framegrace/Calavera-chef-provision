#! /usr/bin/env/ruby
require 'chef/provisioning/docker_driver'

chef_env = '_default'
domain = 'calavera.biz'
subdomain = "#{domain}"

hname="cerebro"
machine_image "#{hname}.#{domain}" do

 #recipe             "git::default"
 recipe             "cerebro::default"

 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
 #action :destroy
end

hname="brazos"
machine_image "#{hname}.#{domain}" do

 recipe             "java7::default"
 recipe             "localAnt::default"
 recipe             "brazos::default"
 recipe             "git::default"
 recipe             "tomcat::default"
 recipe             "shared::_junit"

 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
end


hname="espina"
machine_image "#{hname}.#{domain}" do

 recipe  "base::default"
 recipe  "shared::default"
 recipe  "java7::default"
 recipe  "espina::default"
 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
end

hname="hombros"
machine_image "#{hname}.#{domain}" do

 recipe               "jenkins::master"
 recipe               "hombros::default"

 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
end

hname="manos"
machine_image "#{hname}.#{domain}" do

 recipe             "localAnt::default"
 recipe             "java7::default"   # for some reason the Java recipe must be re-run to install Tomcat
 recipe             "shared::_junit"
 recipe             "manos::default"

 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
 #action :destroy
end

hname="cara"
machine_image "#{hname}.#{domain}" do

 recipe             "java7::default"   # for some reason the Java recipe must be re-run to install Tomcat
 recipe             "cara::default"

 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
 #action :destroy
end
