This is fork uses Docker containers instead of VirtualBox. I needed Calavera to be run on virtualized hosts, and is much easier to do that with Docker. Not all virtualization technologies allow to run nested Virtual Machines, also is much more lightweight for this uses. (Also adds some isolation quirks, which required some work)

I've also added a "dnsmasq" only container, which really eases the inter-container and host-container communications. (Something on which docker also have some problems)

Installation instructions
==
- Install Latest vagrant version from [here] (http://www.vagrantup.com/downloads.html). (Download the package and install it with "sudo dpkg -i")
- Install latest docker.
  - ``wget -qO- https://get.docker.com/ | sudo sh``
- Install build-essential (Some steps may require compile things)
  - ``sudo apt-get install build-essential ``
- Install chef-dk from [here] (https://downloads.chef.io/chef-dk/). This includes berkshelf, needed for the provision. Install it with:
  - `` sudo dpkg -i chefdk_0.6.2-1_amd64.deb ``
- Install berkshelf for provision with:
  - `` sudo chef gem install berkshelf ``
- Install the vagrant-berkshelf plugin
  - ``vagrant plugin install vagrant-berkshelf `` 
- Clone this repo on some dir. And, as "root" user go inside the Calavera repo. (All environment handling must be done as root)
  - ``git clone <clone_url_for_this_repo>``
- Copy your SSH keys to the shared/keys directory (if you don't have those keys, run 
  - ``ssh-keygen -t rsa`` 
and then copy the contents of $HOME/.ssh to the shared/keys directory
- First time build the Calavera machines with:
  - `` ./calavera.build.sh ``
  - Every time you run this script, all the nodes will be destroyed and purged. So just use it when you want to initialize or to completelly clean the environment.
- You can handle the nodes "brazos","espina",etc... with normal vagrant commands.
- Everytime you want to re/start the environment, use:
  - ``./calavera.startup.sh`` 
  - This will make the environment up and running in case it was in an unstabe state.
- Be careful with your DNS settings. As stated here ( http://stackoverflow.com/questions/23012273/setting-up-docker-dnsmasq) When using the dnsmasq container, it's important to keep in mind that it will use the information in the ``/etc/resolv.conf`` of the host system and that content is usually a dynamic configuration. You will need that the DNS server points to the local IP@ where the docker dnsmasq server is bound (usually eth0). So you shoud:
  - Set up the ``/etc/resolv.conf`` file adding a line that says ``nameserver 172.16.251.151``
  - ``sudo docker stop dnsmasq``
  - ``sudo docker start dnsmasq``
