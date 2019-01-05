Ghost 
=====

### Übersicht 

    +---------------------------------------------------------------+
    ! Container: Ghost                                              !	
    ! Container: MySQL                                              !	
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
    
[Ghost](https://hub.docker.com/_/ghost/) ist eine Open Source Blogging Plattform, die in JavaScript geschrieben ist.

**Starten:**

	cd services/ghost
	vagrant up

**User Interface:**

[http://localhost:2368](http://localhost:2368)

**Testen:**

	docker run -d --rm --name adminer -p8080:8080 --link ghost_mysql:mysql adminer

[http://localhost:8080](http://localhost:8080) anwählen.

Server  : ghost_mysql
User    : ghost
Password: secret
Database: ghost

Tabelle `posts` editieren.

### Docker Repositories

* [ghost](https://hub.docker.com/_/ghost/)
* [Offizielles MySQL Image](https://hub.docker.com/_/mysql/) 


### Docker Befehlszeile

Im `Vagrantfile` werden folgende Befehle ausgeführt:

	docker run -d --name ghost_mysql -e MYSQL_ROOT_PASSWORD=admin -e MYSQL_USER=ghost -e MYSQL_PASSWORD=secret \
		   -e MYSQL_DATABASE=ghost --restart=always mysql:5.7
	docker run -d --name ghost --link ghost_mysql:mysql -e database__client=mysql -e database__connection__host=ghost_mysql \
			-e database__connection__user=ghost -e database__connection__password=secret -e database__connection__database=ghost \
			-p 2368:2368 --restart=always ghost:1-alpine
