Advanced Packaging Tool (APT)
-----------------------------

Das [Advanced Packaging Tool (APT)](http://de.wikipedia.org/wiki/Advanced_Packaging_Tool) ist ein Paketverwaltungssystem, das im Bereich des Betriebssystems Debian GNU/Linux entstanden ist und [dpkg](http://de.wikipedia.org/wiki/Debian_Package_Manager) zur eigentlichen Paketverwaltung benutzt. Ziel ist es, eine einfache Möglichkeit zur Suche, Installation und Aktualisierung von Programmpaketen zur Verfügung zu stellen. APT besteht aus einer Programmbibliothek und mehreren diese Bibliothek nutzenden Kommandozeilen-Programmen, von denen **apt-get** und apt-cache zentral sind. Seit Debian 3.1 wird die Benutzung von aptitude als konsolenbasierendes Paketverwaltungssystem empfohlen.

In der Datei **/etc/apt/sources.list** stehen die sogenannten Repositories, also Quellen für Pakete. Dies können entweder CDs oder DVDs, Verzeichnisse auf der Festplatte oder, öfter, Verzeichnisse auf HTTP- oder FTP-Servern sein. Befindet sich das gesuchte Paket auf einem Server (oder einem lokalen Datenträger), so wird dieses automatisch heruntergeladen und installiert.

Die Pakete liegen im Debian-Paketformat (.deb) vor, in dem auch die jeweiligen Abhängigkeiten der Programmpakete untereinander abgelegt sind. So werden automatisch für ein Programm auch eventuell erforderliche Programmbibliotheken mit heruntergeladen und installiert.

### Nützliche Befehle 
   
- `sudo apt-get update`- Repositories aktualisieren
- `sudo apt-get -y install apache2` - Webserver Apache installieren
- `sudo apt-get -y upgrade`- bestehende Software aktualisieren
- `sudo apt-get -y autoremove` - Aufräumen, nicht mehr benötigte Software entfernen                        
- `sudo apt-cache search [keyword]` - Suchen nach einem bestimmen Programmpaket.
- `sudo dpkg -i [Programmpaket]` - Installieren eines vorher downloadeten Programmpaketes

### Testen

Repository aktualisieren

	sudo apt-get update
	
Apache Webserver Installieren

	sudo apt-get install apache2 
	
Testen ob Apache Webserver läuft

	curl localhost
	
### Lokale Packetquellen verwenden (optional)

Auf dem TBZ Repository Server stehen die gespiegelten (`apt-mirror`) [Ubuntu Packetquellen](http://10.1.66.11/apt-mirror) zur Verfügung.

Um diese anstelle der Standard Packetquellen zu verwenden ist der Inhalt der Datei `/etc/apt/sources.list` mit nachfolgendem Inhalt zu ersetzen, z.B. mit `nano`:
 
	## Note, this file is written by cloud-init on first boot of an instance
	## modifications made here will not survive a re-bundle.
	## if you wish to make changes you can:
	## a.) add 'apt_preserve_sources_list: true' to /etc/cloud/cloud.cfg
	##     or do the same in user-data
	## b.) add sources in /etc/apt/sources.list.d
	## c.) make changes to template file /etc/cloud/templates/sources.list.tmpl
	deb http://10.1.66.11/apt-mirror/mirror/archive.ubuntu.com/ubuntu xenial main restricted
	deb http://10.1.66.11/apt-mirror/mirror/archive.ubuntu.com/ubuntu xenial-updates main restricted
	deb http://10.1.66.11/apt-mirror/mirror/archive.ubuntu.com/ubuntu xenial-security main restricted
	
	## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
	## team. Also, please note that software in universe WILL NOT receive any
	## review or updates from the Ubuntu security team.
	deb http://10.1.66.11/apt-mirror/mirror/archive.ubuntu.com/ubuntu xenial universe
	
**Links**

*   [Paketmanagement](http://debiananwenderhandbuch.de/paketmanagement.html)
*   [Systemsicherheit](http://debiananwenderhandbuch.de/sicherheit.html)
*   [25 Useful Basic Commands of APT-GET and APT-CACHE for Package Management](http://www.tecmint.com/useful-basic-commands-of-apt-get-and-apt-cache-for-package-management/)
