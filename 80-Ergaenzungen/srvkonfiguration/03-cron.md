Cron
----

	SHELL=/bin/sh
	PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	
	# m h dom mon dow user  command
	17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
	25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
	47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
	52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
	
/etc/crontab: system-wide crontab	

- - - 

Der Cron-Daemon ist ein Dienst, der automatisch Skripte und Programme zu vorgegebenen Zeiten starten kann. 

Der auszuführende Befehl wird in einer Tabelle, der "crontab", gespeichert. 

Es gibt eine systemweite Datei `/etc/crontab`, die nur mit Root-Rechten bearbeitet werden kann. Zusätzlich kann jeder Benutzer eine eigene Crontab erstellen, die man dann im Verzeichnis `/var/spool/cron/crontabs/` findet.

Diese Tabelle besteht aus sieben bzw. sechs Spalten. Die ersten fünf dienen der Zeitangabe (Minute, Stunde, Tag, Monat, Wochentage) für einen Cronjob, dann folgt (nur in der systemweiten Crontab) der Benutzername, unter dem der Befehl ausgeführt werden soll, und die letzte enthält den Befehl. Die einzelnen Spalten werden durch Leerzeichen oder Tabulatoren getrennt.

### Links

* [Wiki ubuntuusers.de](https://wiki.ubuntuusers.de/Cron/) 
 


