REST Client: cURL
-----------------

[cURL (ausgeschrieben Client for URLs oder Curl URL Request Library)](https://de.wikipedia.org/wiki/CURL) ist ein Kommandozeilen-Programm zum Übertragen von Dateien in Rechnernetzen. Das Programm cURL steht unter der offenen MIT-Lizenz und ist auf verschiedene Betriebssysteme portiert worden. Es ist Bestandteil der meisten Linux-Distributionen und auch von Mac OS X. Die zugehörige Programmbibliothek libcurl wird von zahlreichen Programmen und Programmiersprachen verwendet.

Unter Windows PowerShell gibt es einen Vergleichbaren Befehl [Invoke-WebRequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest).

### Testen von aktiven Ports oder Services mittels cURL

cURL wird auch sehr oft zum Testen von aktiven Ports oder Services benützt. Dazu eigenet sich am Besten die `-f` (HTTP) Fail silently (no output at all) Option.

Testen ob ein Web Server auf localhost läuft und wenn Nein Aktion auslösen

    curl -f http://localhost >/dev/null 2>&1 && { echo "running"; } || { echo "stopped"; }
    
    curl -f http://localhost:8080 >/dev/null 2>&1 && { echo "running"; } || { echo "stopped"; } 

`>/dev/null 2>&1` leitet stdout und stderr ins Nichts um. `&& { <cmd>; } || { <cmd>; }` ist eine if / else Abhandlung von `$?` dem Returnwert jeden Programmes auf Linux.

Die Langform ist:

	curl -f http://localhost >/dev/null 2>&1
	if	[ $? -eq 0 ]
	then
		echo "running"
	else
		echo "stopped"
	fi

### Testen

Shellscript (Datei) `myscript` mit `nano`, `vi` o,ä. mit folgendem Inhalt Erstellen

	#!/bin/bash
	# 
	# Endlosscript wo Testet ob der Apache Webserver läuft
	
	while	[ 1 ]
	do
		curl -f http://localhost >/dev/null 2>&1
		if	[ $? -eq 0 ]
		then
			echo "running"
		else
			echo "stopped"
		fi	
	done
	
Starten des Shellscripts mittels

	bash myscript
	
Das Shellscript kann mittels `Ctrl+C` gestoppt werden.

### Links

* [curl](https://wiki.ubuntuusers.de/curl/)