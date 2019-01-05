Ubuntu/Docker mit MySQL
-----------------------

### Übersicht 

    +---------------------------------------------------------------+
    !                                                               !	
    !    +---------------------+                                    !
    !    ! Datenbank Server    !                                    !       
    !    +---------------------+                                    !
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
	
### Beschreibung MySQL 
    
Ubuntu/Docker VM mit MySQL Docker Image zu Testzwecken.

Image builden:

	cd /vagrant/mysql
	docker build -t mysql .
	
starten:

	docker run --rm -d --name mysql mysql

Funktionsfähigkeit überprüfen:

	docker exec -it mysql bash
	
und im Container

	ps -ef
	
		UID        PID  PPID  C STIME TTY          TIME CMD
		mysql        1     0  0 08:28 ?        00:00:00 mysqld
		root        23     0  2 08:28 pts/0    00:00:00 bash
		root        37    23  0 08:28 pts/0    00:00:00 ps -ef
	
	netstat -tulpen
	
		Active Internet connections (only servers)
		Proto Recv-Q Send-Q Local Address           Foreign Address         State       
		tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN       
		
	exit	
		
MySQL Client im Container starten:

	docker exec -it mysql mysql -uroot -pS3cr3tp4ssw0rd
	
	