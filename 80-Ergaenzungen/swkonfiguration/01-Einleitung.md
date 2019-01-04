Einleitung
----------

<h2 style="font-size: 6.0em; position: relative">/etc</h2>

- - -

Von: et cetera ("alles übrige"), später auch: editable text configuration (änderbare Text Konfiguration);  enthält Konfigurations- und Informationsdateien des Basissystems. Beispiele: fstab, hosts, lsb-release, blkid.tab; hier liegende Konfigurationsdateien können durch gleichnamige Konfigurationsdateien im Homeverzeichnis überlagert werden. Beispiel: bash -> .bashrc

Unterverzeichnisse u.a.:

* /etc/default: Enthält Konfigurationsdateien für den Start von Diensten
* /etc/profile.d: Enthält Scripte welche beim Einloggen eines User durchlaufen werden
* /etc/apache2: Enthält die Konfigurationsdateien für den Web Server Apache
* /etc/mysql: Enthält die Konfigurationsdateien für die MySQL Datenbank
* /etc/network: Verzeichnisse und Konfigurationsdateien des Netzwerkes: Beispiel interfaces
* /etc/init.d (alt) und /etc/systemd: Enthält Start- und Stopskripte für Services 

Verzeichnisse mit der Endung `.d` beinhalten in der Regel mehrere Dateien welche durch eine vorgelagerte Datei includet werden:

Beispiel: `/etc/mysql/my.cnf`

	#
	# The MySQL database server configuration file.
	#
	# You can copy this to one of:
	# - "/etc/mysql/my.cnf" to set global options,
	# - "~/.my.cnf" to set user-specific options.
	#
	!includedir /etc/mysql/conf.d/

### Links

* [Verzeichnisstruktur](https://wiki.ubuntuusers.de/Verzeichnisstruktur/)
* [Apache Konfiguration](https://help.ubuntu.com/lts/serverguide/httpd.html)
* [MySQL Konfiguration](https://help.ubuntu.com/lts/serverguide/mysql.html)