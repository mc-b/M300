# -*- mode: ruby -*-
# vi: set ft=ruby :

#
#	Ubuntu Xenial 64-bit Linux mit Docker
#

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # Create forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. 
  # NOTE: This will enable public access to the opened ports
  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
  config.vm.network "forwarded_port", guest:8081, host:8081, auto_correct: true
  config.vm.network "forwarded_port", guest:8082, host:8082, auto_correct: true
  config.vm.network "forwarded_port", guest:3306, host:3306, auto_correct: true  
  for i in 32760..32780
    config.vm.network :forwarded_port, guest: i, host: i
  end
    
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.hostname = "docker"
  config.vm.network "private_network", ip:"192.168.60.101"
      
  # Share an additional folder to the guest VM.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
  end

  # Docker Provisioner
  config.vm.provision "docker" do |d|
   d.pull_images "ubuntu:14.04"
  end
end
