#! /usr/bin/env/ruby
# Deploy a database server, two app servers, and a load balancer
require 'chef/provisioning/docker_driver'

# global variables
chef_env = '_default'
domain = 'calavera.biz'
#subdomain = "#{chef_env}.#{domain}"
subdomain = "#{domain}"

machine_image "espina.#{domain}" do

 recipe  "base::default"
 recipe  "shared::default"
 recipe  "java7::default"
 recipe  "espina::default"
 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
         :name => 'phusion/baseimage',
         :hostname => "espina.#{domain}",
         :repository => 'phusion',
         :tag => '0.9.16',
     },
    :env => {
         "HOSTNAME" => "espina.#{domain}"
      },
   :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/espina","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   :command => '/sbin/my_init'
 }
 #action :destroy
end

#machine "espina.#{domain}" do
#
 #from_image "espina.#{domain}"
 #recipe  "base::default"
 #recipe  "shared::default"
 #recipe  "java7::default"
 #recipe  "espina::default"
 #chef_environment chef_env
   #machine_options :docker_options => {
     ##:base_image => {
         ##:name => 'phusion/baseimage',
         ##:hostname => "espina.#{domain}",
         ##:repository => 'phusion',
         ##:tag => '0.9.16',
     ##},
    #:env => {
         #"HOSTNAME" => "espina.#{domain}"
      #},
   #:volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/espina","/opt/Calavera-chef-provision/shared:/mnt/shared"],
   #:command => '/sbin/my_init'
 #}
#end
