Ubuntu/Docker mit Apache
------------------------

### Übersicht 

    +---------------------------------------------------------------+
    !                                                               !	
    !    +-------------------------+                                !
    !    ! Web-Server              !                                !       
    !    ! Port: 80                !                                !       
    !    ! Volume: /var/www/html   !                                !       
    !    +-------------------------+                                !
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

Ubuntu/Docker mit Apache Container und Daten (index.html) im HOME Verzeichnis unter web.

Docker Container builden:

	cd /vagrant/apache
	docker build -t apache .

Docker Container starten:

	docker run --rm -d -p 8080:80 -v `pwd`/web:/var/www/html --name apache apache

Funktionsfähigkeit überprüfen Host -> Docker Container

	curl http://localhost:8080
	
Es muss der Inhalt von web/index.html angezeigt werden.

**Testen**

`web/index.html` Datei editieren und mittels `curl` oder Browser testen.


