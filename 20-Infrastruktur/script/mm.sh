#!/bin/bash
#
#	Loesung zu Praxis 3:
#   - Erstellt mehrere VM's abgeleitet aus dem Beispiel von `310-IaC/web` mit jeweils anderer Startseite (index.html).
#	- Fasst die Befehle in einem Bash Script zusammen.
#
#	Verwendetete Ports wie folgt abfragen:
#	vagrant port

for vm in web01 web02 web03 web04
do

    mkdir ${vm}
    cd ${vm}
    
    # Vagrantfile 
    cat <<%EOF% >Vagrantfile
        Vagrant.configure(2) do |config|
          config.vm.box = "ubuntu/xenial64"
          config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
          config.vm.synced_folder ".", "/var/www/html"  
        config.vm.provider "virtualbox" do |vb|
          vb.memory = "256"  
        end
        config.vm.provision "shell", inline: <<-SHELL 
          sudo apt-get update
          sudo apt-get -y install apache2
        SHELL
        end
%EOF%

    # index.html 
    cat <<%EOF% >index.html
    <html>
        <body>
            <h1>Hallo ${vm}</h1>
        </body>
    <html>
%EOF%
    vagrant up
    cd ..
    
done

