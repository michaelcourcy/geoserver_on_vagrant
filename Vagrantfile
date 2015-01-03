# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # We choose a box with a version of puppet lesser than 3.7.x. Othewise many configuration
  # and modules become deprecated. 
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"
  config.vm.box = "CentOS-6.4-x86_64-VirtualBoxGuestAdditions_4.3.2-Chef_11.8.0-Puppet_3.3.1"

  
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "geoserver.local"

  # First manage dependencies 
  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "required-dependencies.pp"
     puppet.module_path = "modules"
   end

  #then set up nginx, tomcat and geoserver
  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "init.pp"
     puppet.module_path = "modules"
  end
  
end
