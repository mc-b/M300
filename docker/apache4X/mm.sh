#!/bin/bash
#
#	Loesung zu Praxis 3:
#   - Erstellt mehrere Docker Container abgeleitet aus dem Beispiel von `230-Volume/docker` mit jeweils anderer Startseite (index.html).
#	- Fasst die Befehle in einem Bash Script zusammen.
#
#	Verwendetete Ports wie folgt abfragen:
#	docker ps

for vm in web01 web02 web03 web04
do

    mkdir ${vm}
    cd ${vm}

    # index.html 
    cat <<%EOF% >index.html
    <html>
        <body>
            <h1>Hallo ${vm}</h1>
        </body>
    <html>
%EOF%

	# Docker bzw. Apache starten
	docker run --rm -d -P -v /vagrant/apache4X/${vm}:/var/www/html --name apache_${vm} apache
    cd ..
    
done

