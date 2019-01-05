OSS Ticket
==========

### Übersicht 

    +---------------------------------------------------------------+
    ! Container: OSS Ticket                                         !	
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

[osTicket](http://osticket.com/) ist ein Open-Source-Support-Ticket-System. 

Es leitet Anfragen, die per E-Mail, Webformularen und Telefonanrufen erstellt wurden, nahtlos in eine einfache, benutzerfreundliche webbasierte Kunden-Support-Plattform für mehrere Benutzer um.

**Starten:**

	cd services/ossticket
	vagrant up
	

**User Interface:**

[http://localhost:8080/scp/](http://localhost:8080/scp/)
	
* username: ostadmin
* password: Admin1
	
### Docker Repositories

* [OSS Ticket](https://hub.docker.com/r/campbellsoftwaresolutions/osticket/)
* [Offizielles MySQL Image](https://hub.docker.com/_/mysql/) 

### Docker Befehlszeile

Im `Vagrantfile` werden folgende Befehle ausgeführt:

	docker run -d --name osticket_mysql -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_USER=osticket \
				-e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=osticket --restart=always mysql

	docker run -d --name osticket --link osticket_mysql:mysql -p 8080:80 --restart=always \
				campbellsoftwaresolutions/osticket
								