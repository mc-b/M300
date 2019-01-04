REST Multi Machine Beispiel
---------------------------

### Übersicht 

	+--------------------+          +---------------------+
	! Web Server         !          ! Datenbank Server    !
	! Host: web01        !          ! Host: db01          !
	! IP: 192.168.55.101 ! <------> ! IP: 192.168.55.100  !
	! Port: 80           !          ! Port 3306           !
	! Nat: 8080          !          ! Nat: -              !
	+--------------------+          +---------------------+
	
### Beschreibung

* Web Server mit Apache und MySQL UserInterface [Adminer](https://www.adminer.org/)
* Datenbank Server mit MySQL

* Die Verbindung Web - Datenbank erfolgt mittels Internen Netzwerk Adapter.
* Von Aussen ist nur der HTTP Port auf dem Web Server Erreichbar.

Um in die VM zu wechseln ist zusätzlich der in Vagrantfile definierte Name einzugeben.

	vagrant ssh database
	vagrant ssh web

Das MySQL User Interface ist via [http://localhost:8080/adminer.php](http://localhost:8080/adminer.php) mit User/Password: root/admin erreichbar.

###  Testen der Server Funktionalität mit cURL

Daten vom Server lesen: HTTP GET

	curl http://192.168.55.101/cgi-bin/rest
	curl http://192.168.55.101/cgi-bin/rest/timestamp
	curl -v -X GET http://192.168.55.101/cgi-bin/rest/timestamp
	
Daten aus der Datenbank lesen

	curl http://192.168.55.101/cgi-bin/restsql

Daten auf Server schreiben: HTTP POST in post.txt und Datenbank

	curl -v -X POST http://192.168.55.101/cgi-bin/rest -d "poti=0.5&hall=0.1&light=0.8&temp=26"
	curl -v -X POST http://192.168.55.101/cgi-bin/restsql -d "poti=0.5&hall=0.1&light=0.8&temp=26"

Datei inkl. Inhalt auf Server erstellen: HTTP PUT

	curl -v -X PUT http://192.168.55.101/cgi-bin/rest?test.txt -d "Das sind Daten fuer den Server"

Datei vom Server löschen: HTTP DELETE

	curl -v -X DELETE http://192.168.55.101/cgi-bin/rest?test.txt 

Die Option -v gibt mehr Informationen, u.a. den HTTP Header, aus und kann auch weggelassen werden. Der Servername ist, je nach Netzwerkeinstellungen, durch die IP-Adresse zu ersetzen.

Die Geschriebenen Dateien können im Browser durch Aufruf von [http://localhost:8080/data/](http://localhost:8080/data/) angeschaut werden.

### Sicherheit

* Datenbank Server bzw. MySQL ist mit Password geschützt.
* Der Web Server ist offen und mittels ungeschütztem HTTP Protokoll erreichbar.