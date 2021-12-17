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

**Links**

*   [Debian-Paketverwaltung verwenden](https://learning.lpi.org/de/learning-materials/101-500/102/102.4/)
*   [Paketmanagement](http://debiananwenderhandbuch.de/paketmanagement.html)
*   [Systemsicherheit](http://debiananwenderhandbuch.de/sicherheit.html)
*   [25 Useful Basic Commands of APT-GET and APT-CACHE for Package Management](http://www.tecmint.com/useful-basic-commands-of-apt-get-and-apt-cache-for-package-management/)
