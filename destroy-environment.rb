#! /usr/bin/env/ruby
require 'chef/provisioning/docker_driver'
with_driver 'docker'

# global variables
chef_env = '_default'
domain = 'calavera.biz'
subdomain = "#{domain}"

execute "zerohosts" do
   command "> /opt/Calavera-chef-provision/dnsmasq.hosts/calavera.biz"
end

%w{cerebro espina cara}.each do |hname|

    machine "#{hname}.#{domain}" do
      action :destroy
    end
end

execute "reload dnsmasq" do
  command "docker kill -s HUP dnsmasq"
end
execute "reload dnsmasq" do
  command 'docker images|grep "^<none"|awk \'{print $3}\'|xargs docker rmi'
  ignore_failure true
end
