# M300 - Plattformübergreifende Dienste in ein Netzwerk integrieren

![M300-Banner](images/Banner_M300_GitHub-Repository.png)

#### Lernziele

Sie können Dienste (engl. Services) plattformübergreifend in einem Netzwerk von Computern verteilen.

#### Voraussetzungen

* PC mit min. 8 GB freiem RAM und ca. 20 GB freiem Harddisk.
* Einfache [Linux](80-Ergaenzungen/) Kenntnisse sind von Vorteil.
* Ein schneller Netzwerk- (Kabel!) und Internet-Anschluss

### Inhaltsverzeichnis

* [10 Toolumgebung aufsetzen](10-Toolumgebung/)
* [20 Infrastruktur-Automatisierung](20-Infrastruktur/)
* [25 Sicherheit](25-Sicherheit/)
* [30 Container](30-Container/)
* [35 Sicherheit](35-Sicherheit/)
* [40 Kubernetes (k8s)](40-Kubernetes/)
* [80 Ergänzungen zu den Unterlagen](80-Ergaenzungen/)

### Beispiele

* [Infrastruktur (vagrant)](vagrant/)
* [Container (docker)](docker/)

### Allgemeine Hinweise

* Die Inhalte sind auf das Modul [300 Plattformübergreifende Dienste in ein Netzwerk integrieren](https://cf.ict-berufsbildung.ch/modules.php?name=Mbk&a=20101&cmodnr=300&noheader=1) zugeschnitten.
* Die Original Inhalte basieren auf dem Projekt [devops](https://github.com/mc-b/devops).
* Formatierungen und Icons von [Michael Blickenstorfer](https://github.com/TacoNaco47/M300), Besten Dank!

### Modulbeschreibung von ICT Berufsbildung
Link: https://cf.ict-berufsbildung.ch/modules.php?name=Mbk&a=20101&cmodnr=300&noheader=1

<b> Modul </b>     | Plattformübergreifende Dienste in ein Netzwerk integrieren
-------------------|---------------------------------------------------------------------------------------------------------------------------------------
<b> Kompetenz </b> | Plattformübergreifende Dienste nach Vorgabe für eine heterogene Systemumgebung konfigurieren, in Betrieb nehmen, testen und freigeben.
  
--------------------
  
 - ** Handlungsziele ** 
  - **_Handlungsnotwendige Kenntnisse_** 
                      
1.	Aus den Vorgaben die erforderlichen Dienste ermitteln, Schutz- und Sicherheitsanforderungen ableiten und ein Konzept für die Integration der Dienste ausarbeiten. 
  1. _Kennt die Einsatz- und Konfigurationsmöglichkeiten der vorgegebenen Betriebssysteme und Dienste._
 
2. Clients und Server gemäss Vorgaben konfigurieren, einrichten und geforderte Funktionalität überprüfen. 
  1. 	Kennt die übliche (best practice) Vorgehensweise bei der Inbetriebnahme von Serverdiensten (zB. installieren, konfigurieren, starten, testen).
  2. 	Kennt betriebssystemspezifische Konzepte zur Konfiguration von Software (zB. Konfigurationsdateien, Registry, systemweite / benutzerspezifische Konfiguration).
  3. 	Kennt die Möglichkeiten von Betriebssystemen zur Gewährleistung und Absicherung des Zugriffs auf Netzwerk-Ressourcen (Authentifizierung, Autorisierung).
  4. 	Kennt die unterschiedlichen Konzepte, Systembefehle und Hilfsprogramme für die Benutzer- und Rechteverwaltung (zB. User-ID, Zugriffsrechte, Gruppenmitgliedschaft, Standardrechte, Vererbung, Homeverzeichnis).
3. 	Netzwerkverbindungen einrichten, Dienste in Betrieb nehmen und testen. Definierte Schutz- und Sicherheitsmassnahmen überprüfen.
  1. 	Kennt die Konfigurationsmöglichkeiten eines DHCP Servers (zB. Zuweisung einer IP Adresse, einer Subnet-Maske, Angaben zu DNS-Servern, Standard-Gateways).
  2. 	Kennt die Konfigurationsmöglichkeiten eines DNS-Servers .
  3. 	Kennt die notwendigen Einstellungen bei einem Client in einer DHCP-/DNS-Serverumgebung.
  4. 	Kennt die Elemente und Funktionen des TCP/IP-Protokolls (zB. MAC- und IP-Adressen, IP-Adressklassen, private Adressen, Netzmasken, Routing, Adress Resolution Protocol (ARP), wichtige Portnummern).
4. 	Anwendungen und Tools installieren, einrichten und geforderte Funktionalität überprüfen und gemeinsame Ressourcen einbinden 	
  1. 	Kennt technische Möglichkeiten um Ressourcen im Netzwerk durch Gruppen gemeinsam zu nutzen (zB. Groupware).
5. 	Allfällige Fehler systematisch eingrenzen, protokollieren und Massnahmen zur Fehlerbehebung einleiten. 	
  1. 	Kennt Methoden zur systematischen Fehlereingrenzung (zB. Ausschlussverfahren intakter Systeme).
  2. 	Kennt Werkzeuge zur Fehleranalyse und –behebung.
  3. 	Kennt den Aufbau und die wesentlichen Merkmale eines Testprotokolls.
6. 	Dokumentation für die Administration des Netzes, der Rollen und Rechte und der eingerichteten Dienste und Anwendungen erstellen.
  1. 	Kennt Aufbau und Inhalt einer Netzwerk- und Systemdokumentation.
    	 

<tab>    | <tab>
--------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Kompetenzfeld**   | System Management
** Objekt **        | Clients, Server (File, Print, DNS, DHCP, Directory Services, Terminal, SSH, Web) und Peripherie mit unterschiedlichen Betriebssystemen in einem einfachen Netzwerk.
** Niveau **        | 3
** Voraussetzung ** | Konfigurieren und betreiben von PCs. Servern und Peripherie (Multiusersysteme) Erfahrung im Aufbau von lokalen Netzwerken
