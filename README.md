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
- Clone this repo on /opt. And, as "root" user go inside the Calavera repo. (All environment handling must be done as root)
  - ``git clone <clone_url_for_this_repo>``
- Install berkshelf dependencies. 
  - ``cd /opt/Calavera-chef-provision``
  - ``berks install``
- Copy your SSH keys to the shared/keys directory (if you don't have those keys, run 
  - ``ssh-keygen -t rsa`` 
and then copy the contents of $HOME/.ssh to the shared/keys directory
- Build the Calavera environment running (as root)
  - ``create-environment.sh`` 
