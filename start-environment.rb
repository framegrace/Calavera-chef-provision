#! /usr/bin/env/ruby
require 'chef/provisioning/docker_driver'
with_driver 'docker'

# global variables
chef_env = '_default'
domain = 'calavera.biz'
subdomain = "#{domain}"

execute "restart dnsmasq" do
  command "/opt/Calavera-chef-provision/dnsmasq-start.sh"
end

execute "zerohosts" do
   command "> /opt/Calavera-chef-provision/dnsmasq.hosts/calavera.biz"
end

ports=Hash.new
ports['cerebro']=[ "8130:8080","8030:80" ]
ports['brazos']=[ "8131:8080","8031:80" ]
ports['espina']= [ "8132:8081","8032:80" ]
ports['hombros']= [ "8133:8080","8033:80" ]
ports['manos']= [ "8134:8080","8034:80" ]
ports['cara']= [ "8135:8080","8035:80" ]

%w{cerebro brazos espina hombros manos cara}.each do |hname|
#%w{cara}.each do |hname|

    machine "#{hname}.#{domain}" do
     #from_image "#{hname}.#{domain}"
     #if ( hname.eql?("manos")  or hname.eql?(cara))
        #recipe "#{hname}::run"
     #end
     chef_environment chef_env
       machine_options :docker_options => {

      :base_image => {
         :name => "#{hname}.#{domain}",
         :hostname => "#{hname}.#{domain}",
         :repository => 'phusion'
     },

        :env => {
             "HOSTNAME" => "#{hname}.#{domain}"
          },
       :volumes => ["/opt/Calavera-chef-provision:/home/vagrant","/opt/Calavera-chef-provision:/home/#{hname}","/opt/Calavera-chef-provision/shared:/mnt/shared"],
       :command => '/sbin/my_init',
       :ports => ports[hname]
     }
    end
    
    execute "getIP#{hname}" do
       command "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} #{hname}.#{domain} #{hname}' #{hname}.#{domain} >> /opt/Calavera-chef-provision/dnsmasq.hosts/calavera.biz"
    end
    execute "reload dnsmasq" do
       command "docker kill -s HUP dnsmasq"
    end
end

