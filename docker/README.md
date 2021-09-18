Docker Testumgebung 
===================

    +---------------------------------------------------------------+
    ! Container-Engine: Docker                                      !	
    +---------------------------------------------------------------+
    ! Gast OS: Ubuntu 16.04                                         !	
    +---------------------------------------------------------------+
    ! Hypervisor: VirtualBox                                        !	
    +---------------------------------------------------------------+
    ! Host-OS: Windows, MacOS, Linux                                !	
    +---------------------------------------------------------------+
    ! Notebook - Schulnetz 10.x.x.x                                 !                 
    +---------------------------------------------------------------+

### Beschreibung
***

Zum einstimmen in das Thema. 

* [app - eine einfache NodeJS App](app/)

Anschliessend, diese einfache VM mit Docker installiert, erstellen.

    cd docker
    vagrant up
    vagrant ssh

In der VM können folgende Beispiele ausprobiert werden:

* [Einfache NodeJS App erstellen](https://gitlab.com/ser-cal/Container-CAL-webapp_v1), statt `ssh` - `vagrant ssh` verwenden.
* [apache - Apache Web Server](apache/)
* [db - MySQL Datenbank](mysql/)
* [apache4X - Scriptscript welches 4 Web Server Container erstellt](apache4X/)
* [compose - Docker Compose](compose/)
* [dotnet - .NET Entwicklungsumgebung](dotnet/)
* [jenkins - Build Umgebung](jenkins/)
* [microservice - Micro Service mit Node.js](microservice/)

Es muss einmalig die VM mit Docker erstellt und in die VM gewechselt werden:

	vagrant up
	vagrant ssh

Die Beispiele befinden sich, in der VM, im Verzeichnis `/vagrant`. Die Anwahl ist wie folgt:

	cd /vagrant/<Beispiel>
	
Die VM kann wie folgt verlassen heruntergefahren und gelöscht werden:

	exit
	vagrant halt
	vagrant destroy -f
	
