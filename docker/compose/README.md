Ubuntu/Docker mit MySQL und Apache
----------------------------------

### Übersicht 

    +---------------------------------------------------------------+
    !                                                               !	
    !    +-----------------------+    +------------------------+    !
    !    ! Web-Server            !    ! Datenbank-Server       !    !       
    !    ! Port: 80              !    ! Port: 3306             !    !       
    !    ! Volume: /var/www/html !    ! Volume: /var/lib/mysql !    !       
    !    +-----------------------+    +------------------------+    !
    !                                                               !	
    ! Container                                                     !	
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
    
Ubuntu/Docker VM mit MySQL Docker Image und den MySQL Client installiert auf dem Host und der Apache Web Server.

Docker Compose installieren:

	sudo apt-get install docker-compose

Images müssen bereits gebuildet sein (siehe [apache](../apache) und [mysql](../mysql), es wird nur `docker-compose` gestartet.

    cd /vagrant/compose 
    docker-compose up -d
	
**Testen:**

Apache: 

	http://localhost:8080 

MySQL:

	docker exec -it compose_mysql_1 bash
	
und im Container

	ps -ef
	netstat -tulpen
	ping compose_apache_1
	exit

MySQL Client im Container starten und Zugriff via Host freischalten:

	docker exec -it mysql mysql -uroot -pS3cr3tp4ssw0rd

	CREATE USER 'root'@'%' IDENTIFIED BY 'admin';
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
	FLUSH PRIVILEGES;

MySQL Client auf dem Host starten:

	mysql -uroot -padmin -h127.0.0.1	