#! /usr/bin/env/ruby
# Deploy a database server, two app servers, and a load balancer
require 'chef/provisioning/docker_driver'

# global variables
chef_env = '_default'
domain = 'calavera.biz'
#subdomain = "#{chef_env}.#{domain}"
subdomain = "#{domain}"

machine_image "espina" do

 recipe  "base::default"
 recipe  "shared::default"
 recipe  "java7::default"
 recipe  "espina::default"
 chef_environment chef_env
   machine_options :docker_options => {
     :base_image => {
     :name => 'phusion/baseimage',
     :repository => 'phusion',
     :tag => '0.9.16'
   },
   :volumes => ["/opt/Calavera-chef:/home/vagrant","/opt/Calavera-chef:/home/espina","/opt/Calavera-chef/shared:/mnt/shared"]
 }
end
