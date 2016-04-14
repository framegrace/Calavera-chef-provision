#! /usr/bin/env/ruby
# Deploy a database server, two app servers, and a load balancer
require 'chef/provisioning/docker_driver'

# global variables
chef_env = '_default'
domain = 'calavera.biz'
subdomain = "#{domain}"

hname="cerebro"
machine "#{hname}.#{domain}" do

 from_image "#{hname}.#{domain}"
 #recipe  "base::default"
 #recipe  "shared::default"
 #recipe  "java7::default"
 #recipe  "espina::default"
 chef_environment chef_env
   machine_options :docker_options => {
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init',
   :ports => [ "8130:8080","8030:80" ]
 }
end

hname="espina"
machine "#{hname}.#{domain}" do

 from_image "#{hname}.#{domain}"
 recipe  "base::default"
 recipe  "shared::default"
 recipe  "java7::default"
 recipe  "espina::default"
 chef_environment chef_env
   machine_options :docker_options => {
    :env => {
         "HOSTNAME" => "#{hname}.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init',
   :ports => [ "8132:8081","8032:80" ]
 }
end
