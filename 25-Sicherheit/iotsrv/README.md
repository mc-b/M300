MultiMachine Beispiel
---------------------

### Beschreibung

* Web Server mit Apache und MySQL UserInterface [Adminer](https://www.adminer.org/)
* Datenbank Server mit MySQL
* Master Server mit cgi-bin/rest um die Daten in http://localhost:8081/data abzulegen.

* Die Verbindung Web - Datenbank erfolgt mittels Internen Netzwerk Adapter.
* Von Aussen ist der HTTP Port auf dem Web (http://localhost:8080) und Master (http://localhost:8081) Server Erreichbar.

Um in die VM zu wechseln ist zusätzlich der in Vagrantfile definierte Name einzugeben.

	vagrant ssh database
	vagrant ssh web
	vagrant ssh master

Das MySQL User Interface ist via [http://localhost:8080/adminer.php](http://localhost:8080/adminer.php) mit User/Password: root/admin erreichbar.

### Sicherheit

* Datenbank Server bzw. MySQL ist mit Password geschützt.
* Der Web und Master Server ist offen und mittels ungeschütztem HTTP Protokoll erreichbar.