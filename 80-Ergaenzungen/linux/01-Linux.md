Linux
-----

![](../../images/LinuxDesktop.png)

- - - 

Als Linux bezeichnet man in der Regel freie, unix-ähnliche Mehrbenutzer-Betriebssysteme, die auf dem Linux-Kernel und wesentlich auf GNU-Software basieren.

Das modular aufgebaute Betriebssystem wird von Softwareentwicklern auf der ganzen Welt weiterentwickelt, die an den verschiedenen Projekten mitarbeiten. An der Entwicklung sind Unternehmen, Non-Profit-Organisationen und viele Freiwillige beteiligt. 

Beim Gebrauch auf Computern kommen meist sogenannte Linux-Distributionen zum Einsatz. Eine Distribution fasst den Linux-Kernel mit verschiedener Software zu einem Betriebssystem zusammen, das für die Endnutzung geeignet ist. Dabei passen viele Distributoren und versierte Benutzer den Kernel an ihre eigenen Zwecke an.

Wir Verwenden die [Ubuntu](https://de.wikipedia.org/wiki/Ubuntu) Linux Distribution.

### Installation

Für das weitere Prototypen eignet sich am besten der Ubuntu Server.

Dazu Installieren Sie einen Ubuntu Server in VirtualBox.

### Testen

* [Ubuntu Server](https://www.ubuntu.com/download/desktop) Image herunterladen.
  
* Erstellen einer VirtualBox VM mit Linux und dem heruntergeladenen Image als CD Laufwerk.

* Beim Netzwerk ist unter NAT der Port 80 als Weiterleitung zu Port 8080 (Host) einzutragen

* Booten der VM und Installieren der Linux Server Umgebung.
 
* Apache Server auf der Kommandozeile installieren

	sudo apt-get install apache2

* Testen mittels Starten des Browsers und Angabe von [http://localhost:8080](http://localhost:8080).

* Optional: Ins Verzeichnis `/var/www/html` wechseln und Startseite Apache Webserver `index.html` ändern.

### Links

* [Linux Grundlagen](https://www.tuxcademy.org/media/basic/)