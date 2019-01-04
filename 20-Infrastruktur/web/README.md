Beispiel: einfacher Webserver
-----------------------------

Einfacher Webserver mit Ubuntu 16.x.

### Erstellen und Starten der VM 

    cd web
    vagrant up
 
Die Dateien werden lokal im aktuellen Verzeichnis abgelegt: 

	config.vm.synced_folder ".", "/var/www/html"

Der Webserver ist unter [http://localhost:8080](http://localhost:8080) erreichbar.

    config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
	 
Falls dieser belegt ist, wird automatisch eine Alternative gewählt.

### Tests

* `index.html` (Startdatei Apache Web Server) Datei in diesem Verzeichnis editieren und Änderungen via [http://localhost:8080](http://localhost:8080) überprüfen. 