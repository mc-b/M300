MultiMachine Beispiel
---------------------
### Übersicht 

    +-------------------------------------------------------------------------------------------------+
    ! Notebook - Schulnetz 10.x.x.x und Privates Netz 192.168.55.1                                    !                 
    ! Port: 8080 (192.158.55.101:80)                                                                  !
    ! Port: 22 (10.x.x.x und 192.168.55.1)                                                            !	
    !                                                                                                 !	
    !    +--------------------+          +---------------------+          +---------------------+     !
    !    ! Web Server         !          ! Datenbank Server    !          ! Master (LDAP, REST) !     !       
    !    ! Host: web01        !          ! Host: db01          !          ! Host: master        !     !
    !    ! IP: 192.168.55.101 !          ! IP: 192.168.55.100  !          ! IP: 192.168.55.102  !     !
    !    ! Port: 80           !          ! Port 3306           !          ! Port 80             !     !
    !    ! Nat: 8080          !          ! Nat: -              !          ! Nat: -              !     !
    !    ! Port: 22           !          ! Port: 22            !          ! Port: 22            !     !
    !    +--------------------+          +---------------------+          +---------------------+     !
    !                                                                                                 !	
    +-------------------------------------------------------------------------------------------------+
    
### Beschreibung

* Web Server mit Apache, MySQL UserInterface [Adminer](https://www.adminer.org/) und Reverse Proxy
* Datenbank Server mit MySQL
* Master Server mit cgi-bin/rest (CGI, REST), OpenLDAP Server und NMAP 

* Die Verbindung Web - Datenbank erfolgt mittels Privaten Netzwerk Adapter.
* Die Verbindung Web - Master erfolgt mittels Privaten Netzwerk Adapter.
* Der Master ist nur via Web Server erreichbar (Firewall!)

Um in die VM zu wechseln ist zusätzlich der in Vagrantfile definierte Name einzugeben.

	vagrant ssh database
	vagrant ssh web
	vagrant ssh master
	
### Funktionen

* HTTP Server (Web) [http://localhost:8080](http://localhost:8080) und Master ([http://localhost:8080/master](http://localhost:8080/master)
* MySQL Server - User Interface ist mittels [http://localhost:8080/adminer.php](http://localhost:8080/adminer.php) mit User/Password: root/admin erreichbar.
* OpenLDAP Server [http://localhost:8080/master/phpldapadmin](http://localhost:8080/master/phpldapadmin)
* REST - [http://localhost:8080/master/cgi-bin/rest](http://localhost:8080/master/cgi-bin/rest) und die Daten [http://localhost:8080/master/data](http://localhost:8080/master/data)
* NMAP - [http://localhost:8080/master/cgi-bin/network/](http://localhost:8080/master/cgi-bin/network/)

### Sicherheit

* Datenbank Server bzw. MySQL ist mit Password geschützt.
* Der Web Server ist mittels Port 8080 erreichbar.
* Der Master Server ist mittels Firewall geschützt und kann nur mittels Web Server erreicht werden.

**Testen**

	vagrant ssh web
	curl -f http://master		# i.o.
	curl -f http://db01:3306	# i.o.
	exit
	
	vagrant ssh database
	curl -f http://master		# fail!
	exit
	
	vagrant ssh master
	curl -f http://db01:3306	# fail!
	exit
	
