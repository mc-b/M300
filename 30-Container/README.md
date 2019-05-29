M300 - 30 Container 
===================

Diese Wikiseite zeigt auf wie Applikationen und Services, als Container (Containerisiert) betrieben werden können.

#### Lernziele

Sie können Applikationen und Services als Container betrieben und als Container Images für Dritte zur Verfügung stellen.

#### Voraussetzungen

* [10 Toolumgebung](../10-Toolumgebung/)

#### Inhaltsverzeichnis

* 01 - [Container](#-01---container)
* 02 - [Docker](#-02---docker)
* 03 - [Netzwerk-Anbindung (optional)](#-03---netzwerk-anbindung)
* 04 - [Volumes (optional)](#-04---volumes)
* 05 - [Image-Bereitstellung](#-05---image-bereitstellung)
* 06 - [Reflexion](#-06---reflexion)
* 07 - [Fragen](Fragen.md)
* 08 - [LB 3 hands-on](LB3.md)
* 09 - [Beispiele (für LB3)](#-09---beispiele-für-lb3)
* 10 - [Quellenverzeichnis](#-10---quellenverzeichnis)

___

![](../images/Ship_36x36.png "Container") 01 - Container
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Container ändern die Art und Weise, wie wir Software entwickeln, verteilen und laufen lassen, grundlegend.

Entwickler können Software lokal bauen, die woanders genauso laufen wird – sei es ein Rack in der IT-Abteilung, der Laptop eines Anwenders oder ein Cluster in der Cloud.

Administratoren können sich auf die Netzwerke, Ressourcen und die Uptime konzentrieren und müssen weniger Zeit mit dem Konfigurieren von Umgebungen und dem Kampf mit Systemabhängigkeiten verbringen.

**Merkmale** <br>
* Container teilen sich Ressourcen mit dem Host-Betriebssystem
* Container können im Bruchteil einer Sekunde gestartet und gestoppt werden
* Anwendungen, die in Containern laufen, verursachen wenig bis gar keinen Overhead
* Container sind portierbar --> Fertig mit "Aber bei mir auf dem Rechner lief es doch!"
* Container sind leichtgewichtig, d.h. es können dutzende parallel betrieben werden.
* Container sind "Cloud-ready"!


### Geschichte
***
Container sind ein altes Konzept. Schon seit Jahrzehnten gibt es in UNIX-Systemen den Befehl chroot, der eine einfache Form der Dateisystem-Isolation bietet.

Seit 1998 gibt es in FreeBSD das Jail-Tool, welches das chroot-Sandboxing auf Prozesse erweitert.

Solaris Zones boten 2001 eine recht vollständige Technologie zum Containerisieren, aber diese war auf Solaris OS beschränkt.

Ebenfalls 2001 veröffentlichte Parallels Inc. (damals noch SWsoft) die kommerzielle Containertechnologie Virtuozzo für Linux, deren Kern später (im Jahr 2005) als Open Source unter dem Namen OpenVZ bereitgestellt wurde.

Dann startete Google die Entwicklung von CGroups für den Linux-Kernel und begann damit, seine Infrastruktur in Container zu verlagern.

Das Linux Containers Project (LXC) wurde 2008 initiiert, und in ihm wurden (unter anderem) CGroups, Kernel-Namensräume und die chroot-Technologie zusammengeführt, um eine vollständige Containerisierungslösung zu bieten.

2013 lieferte Docker schliesslich die fehlenden Teile für das Containerisierungspuzzle, und die Technologie begann den Mainstream zu erreichen.

Siehe auch [The Missing Introduction To Containerization](https://medium.com/devopslinks/the-missing-introduction-to-containerization-de1fbb73efc5)

### Microservices
***

[![](https://img.youtube.com/vi/PH4HtZ8naWs/0.jpg)](https://www.youtube.com/watch?v=PH4HtZ8naWs)

Microservices YouTube Einführung

---

Einer der grössten Anwendungsfälle und die stärkste treibende Kraft hinter dem Aufstieg von Containern sind Microservices.

Microservices sind ein Weg, Softwaresysteme so zu entwickeln und zu kombinieren, dass sie aus kleinen, unabhängigen Komponenten bestehen, die untereinander über das Netz interagieren. Das steht im Gegensatz zum klassischen, monolithischen Weg der Softwareentwicklung, bei dem es ein einzelnes, grosses Programm gibt.

Wenn solch ein Monolith dann skaliert werden muss, kann man sich meist nur dazu entscheiden, vertikal zu skalieren (scale up), zusätzliche Anforderungen werden in Form von mehr RAM und mehr Rechenleistung bereitgestellt. Microservices sind dagegen so entworfen, dass sie horizontal skaliert werden können (scale out), indem zusätzliche Anforderungen durch mehrere Rechner verarbeitet werden, auf die die Last verteilt werden kann.

In einer Microservices-Architektur ist es möglich, nur die Ressourcen zu skalieren, die für einen bestimmten Service benötigt werden, und sich damit auf die Flaschenhälse des Systems zu beschränken. In einem Monolith wird alles oder gar nichts skaliert, was zu verschwendeten Ressourcen führt.

![](../images/Docker_36x36.png?raw=true "Docker") 02 - Docker
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

[![](https://img.youtube.com/vi/YFl2mCHdv24/0.jpg)](https://www.youtube.com/watch?v=YFl2mCHdv24)

Docker YouTube Einführung

---

Docker nahm die bestehende Linux-Containertechnologie auf und verpackte und erweiterte sie in vielerlei Hinsicht – vor allem durch portable Images und eine benutzerfreundliche Schnittstelle –, um eine vollständige Lösung für das Erstellen und Verteilen von Containern zu schaffen.

Die Docker-Plattform besteht vereinfacht gesagt aus zwei getrennten Komponenten: der Docker Engine, die für das Erstellen und Ausführen von Containern verantwortlich ist, sowie dem Docker Hub, einem Cloud Service, um Container-Images zu verteilen.

**Wichtig:** Docker wurde für 64-bit Linux Systeme entwickelt, kann jedoch auch mittels VirtualBox auf Mac und Windows betrieben werden.


### Architektur
***

Nachfolgend sind die wichtigsten Komponenten von Docker aufgelistet:

**Docker Deamon** <br>
* Erstellen, Ausführen und Überwachen der Container
* Bauen und Speichern von Images

Der Docker Daemon wird normalerweise durch das Host-Betriebssystem gestartet.

**Docker Client** <br> 
* Docker wird über die Kommandozeile (CLI) mittels des Docker Clients bedient
* Kommuniziert per HTTP REST mit dem Docker Daemon

Da die gesamte Kommunikation über HTTP abläuft, ist es einfach, sich mit entfernten Docker Daemons zu verbinden und Bindings an Programmiersprachen zu entwickeln.

**Images** <br> 
* Images sind gebuildete Umgebungen welche als Container gestartet werden können
* Images sind nicht veränderbar, sondern können nur neu gebuildet werden.
* Images bestehen aus Namen und Version (TAG), z.B. *ubuntu:16.04.* 
    * Wird keine Version angegeben wird automatisch :latest angefügt.

**Container** <br> 
* Container sind die ausgeführten Images
* Ein Image kann beliebig oft als Container ausgeführt werden
* Container bzw. deren Inhalte können verändert werden, dazu werden sogenannte *Union File Systems* verwendet, welche nur die Änderungen zum original Image speichern.

**Docker Registry** <br> 
* In Docker Registries werden Images abgelegt und verteilt

Die Standard-Registry ist der Docker Hub, auf dem tausende öffentlich verfügbarer Images zur Verfügung stehen, aber auch "offizielle" Images.

Viele Organisationen und Firmen nutzen eigene Registries, um kommerzielle oder "private" Images zu hosten, aber auch um den Overhead zu vermeiden, der mit dem Herunterladen von Images über das Internet einhergeht. 


### Befehle
***
Der Docker Client bietet eine Vielzahl von Befehlen, die für die Bedienung der Anwendung genutzt werden können. In diesem Abschnitt werden daher jene Befehle etwas näher beleuchtet.

**docker run** <br>
* Ist der Befehl zum Starten neuer Container.
* Der bei weitem komplexesten Befehl, er unterstützt eine lange Liste möglicher Argumente.
* Ermöglicht es dem Anwender, zu konfigurieren, wie das Image laufen soll, Dockerfile-Einstellungen zu überschreiben, Verbindungen zu konfigurieren und Berechtigungen und Ressourcen für den Container zu setzen.

Standard-Test:
```Shell
    $ docker run hello-world
```

Startet einen Container mit einer interaktiven Shell (interactive, tty):
```Shell
    $ docker run -it ubuntu /bin/bash
```

Startet einen Container, der im Hintergrund (detach) läuft:
```Shell
    $ docker run -d ubuntu sleep 20
```

Startet einen Container im Hintergrund und löscht (remove) diesen nach Beendigung des Jobs:
```Shell
    $ docker run -d --rm ubuntu sleep 20
```

Startet einen Container im Hintergrund und legt eine Datei an:
```Shell
    $ docker run -d ubuntu touch /tmp/lock
```

Startet einen Container im Hintergrund und gibt das ROOT-Verzeichnis (/) nach STDOUT aus:
```Shell
    $ docker run -d ubuntu ls -l
```

**docker ps** <br>
* Gibt einen Überblick über die aktuellen Container, wie z.B. Namen, IDs und Status.

Aktive Container anzeigen:
```Shell
    $ docker ps
```

Aktive und beendete Container anzeigen (all):
```Shell
    $ docker ps -a
```

Nur IDs ausgeben (all, quit):
```Shell
    $ docker ps -a -q
```

**docker images** <br>
* Gibt eine Liste lokaler Images aus, wobei Informationen zu Repository-Namen, Tag-Namen und Grösse enthalten sind.

Lokale Images ausgeben:
```Shell
    $ docker images
```

Alternativ auch mit `... image ls`:
```Shell
    $ docker image ls
```

**docker rm und docker rmi** <br>
* `docker rm`
    *  Entfernt einen oder mehrere Container. Gibt die Namen oder IDs erfolgreich gelöschter Container zurück.
* `docker rmi`
    *  Löscht das oder die angegebenen Images. Diese werden durch ihre ID oder Repository- und Tag-Namen spezifiziert.

Docker Container löschen:
```Shell
    $ docker rm [name]
```

Alle beendeten Container löschen:
```Shell
    $ docker rm `docker ps -a -q`
```

Alle Container, auch aktive, löschen:
```Shell
    $ docker rm -f `docker ps -a -q`
```

Docker Image löschen:
```Shell
    $ docker rmi ubuntu
```

Zwischenimages löschen (haben keinen Namen):
```Shell
    $ docker rmi `docker images -q -f dangling=true`
```

**docker start** <br>
* Startet einen (oder mehrere) gestoppte Container. 
    * Kann genutzt werden, um einen Container neu zu starten, der beendet wurde, oder um einen Container zu starten, der mit `docker create` erzeugt, aber nie gestartet wurde.

Docker Container neu starten, die Daten bleiben erhalten:
```Shell
    $ docker start [id]
```

**Container stoppen, killen** <br>
* `docker stop`
    * Stoppt einen oder mehrere Container (ohne sie zu entfernen). Nach dem Aufruf von `docker stop` für einen Container wird er in den Status »exited« überführt.
* `docker kill`
    * Schickt ein Signal an den Hauptprozess (PID 1) in einem Container. Standardmässig wird SIGKILL gesendet, womit der Container sofort stoppt.

**Informationen zu Containern** <br>
* `docker logs`
    * Gibt die "Logs" für einen Container aus. Dabei handelt es sich einfach um alles, was innerhalb des Containers nach STDERR oder STDOUT geschrieben wurde.
* `docker inspect`
    * Gibt umfangreiche Informationen zu Containern oder Images aus. Dazu gehören die meisten Konfigurationsoptionen und Netzwerkeinstellungen sowie Volumes-Mappings.
* `docker diff`
    * Gibt die Änderungen am Dateisystem des Containers verglichen mit dem Image aus, aus dem er gestartet wurde.
* `docker top`
    * Gibt Informationen zu den laufenden Prozessen in einem angegebenen Container aus.


### Dockerfile
***
Ein Dockerfile ist eine Textdatei mit einer Reihe von Schritten, die genutzt werden können, um ein Docker-Image zu erzeugen.

Dazu wird zuerst ein Verzeichnis erstellt und darin eine Datei mit Namen "Dockerfile".

Anschliessend kann das Image wie folgt gebuildet werden:
```Shell
    $ docker build -t mysql .
```

Starten:
```Shell
    $ docker run --rm -d --name mysql mysql
```

Funktionsfähigkeit überprüfen:
```Shell
    $ docker exec -it mysql bash
```

Überprüfung im Container:
```Shell
    $ ps -ef
    $ netstat -tulpen
```

### Konzepte
***

**Build Context** <br>
* Der Befehl `docker build` erfordert ein Dockerfile und einen Build Context.
    * Der Build Context ist der Satz lokaler Dateien und Verzeichnisse, die aus ADD- oder COPY-Anweisungen im Dockerfile angesprochen werden können.
    * Er wird im Allgemeinen als Pfad zu einem Verzeichnis definiert.

**Layer / Imageschichten** <br>
* Jede Anweisung in einem Dockerfile führt zu einer neuen Imageschicht – einem Layer –, die wieder zum Starten eines neuen Containers genutzt werden kann.
* Die neue Schicht wird erzeugt, indem ein Container mit dem Image der vorherigen Schicht gestartet, dann die Dockerfile-Anweisung ausgeführt und schliesslich ein neues Image gespeichert wird.
* Ist eine Dockerfile-Anweisung erfolgreich abgeschlossen worden, wird der temporär erzeugte Container wieder gelöscht.

**Anweisungen im Dockerfile** <br>

* `FROM`
    * Welches Base Image von [hub.docker.com](https://hub.docker.com) verwendet werden soll, z.B. ubuntu:16.04
* `ADD`
    *  Kopiert Dateien aus dem Build Context oder von URLs in das Image.
* `CMD`
    * Führt die angegebene Anweisung aus, wenn der Container gestartet wurde. Ist auch ein ENTRYPOINT definiert, wird die Anweisung als Argument für ENTRYPOINT verwendet.
* `COPY`
    * Wird verwendet, um Dateien aus dem Build Context in das Image zu kopieren. Es gibt die zwei Formen COPY src dest und COPY ["src", "dest"]. Das JSON-Array-Format ist notwendig, wenn die Pfade Leerzeichen enthalten.
* `ENTRYPOINT`
    * Legt eine ausführbare Datei (und Standardargumente) fest, die beim Start des Containers laufen soll. 
    * Jegliche CMD-Anweisungen oder an `docker run` nach dem Imagenamen übergebenen Argumente werden als Parameter an das Executable durchgereicht. 
    * ENTRYPOINT-Anweisungen werden häufig genutzt, um "Start-Scripts" anzustossen, die Variablen und Services initialisieren, bevor andere übergebene Argumente ausgewertet werden.
* `ENV`
    * Setzt Umgebungsvariablen im Image.
* `EXPOSE`
    * Erklärt Docker, dass der Container einen Prozess enthält, der an dem oder den angegebenen Port(s) lauscht.
* `HEALTHCHECK`
    * Die Docker Engine prüft regelmässig den Status der Anwendung im Container.
        ```Shell 
            HEALTHCHECK --interval=5m --timeout=3s \ CMD curl -f http://localhost/ || exit 1`
        ```
* `MAINTAINER` 
    * Setzt die "Autor-Metadaten" des Image auf den angegebenen Wert.
* `RUN` 
    * Führt die angegebene Anweisung im Container aus und bestätigt das Ergebnis.
* `SHELL` 
    * Die Anweisung SHELL erlaubt es seit Docker 1.12, die Shell für den folgenden RUN-Befehl zu setzten. So ist es möglich, dass nun auch direkt bash, zsh oder Powershell-Befehle in einem Dockerfile genutzt werden können.
* `USER` 
    * Setzt den Benutzer (über Name oder UID), der in folgenden RUN-, CMD- oder ENTRYPOINT-Anweisungen genutzt werden soll.
* `VOLUME` 
    * Deklariert die angegebene Datei oder das Verzeichnis als Volume. Besteht die Datei oder das Verzeichnis schon im Image, wird sie bzw. es in das Volume kopiert, wenn der Container gestartet wird.
* `WORKDIR` 
    * Setzt das Arbeitsverzeichnis für alle folgenden RUN-, CMD-, ENTRYPOINT-, ADD oder COPY-Anweisungen.



![](../images/Network_36x36.png?raw=true "Netzwerk-Anbindung") 03 - Netzwerk-Anbindung
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Stellen Sie sich vor, Sie lassen einen Webserver in einem Container laufen. Wie können Sie dann der Aussenwelt darauf Zugriff gewähren?

Die Antwort ist, Ports mit den Befehlen -p oder -P zu "veröffentlichen". Dieser Befehl leitet Ports auf den Host des Containers weiter.

**Beispiele** <br>

MySQL Container permanent an Host Port 3306 weiterleiten:
```Shell
    $ docker run --rm -d -p 3306:3306 mysql
```

MySQL Container mit nächsten freien Port verbinden:
```Shell
    $ docker run --rm -d -P mysql
```

**Erweiterung Dockerfile** <br>
Um Ports an den Host bzw. das Netzwerk weiterzuleiten, sind diese im Dockerfile via EXPOSE einzutragen.

Beispiel MySQL-Standardport:
```Shell
    EXPOSE 3306
```

**Zugriff vom Host erlauben** <br>
Um via Host auf den Container zuzugreifen sind ein paar Arbeiten zu erledigen.

Installation des MySQL Clients auf dem Host:
```Shell
    $ sudo apt-get install mysql-client
```

Freigabe des Ports in der MySQL-Config im Container, z.B. via Dockerfile:
```Shell
    RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
```

SQL Freigabe, via MySQL Client im Container einrichten:
```SQL
    CREATE USER 'root'@'%' IDENTIFIED BY 'admin';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
    FLUSH PRIVILEGES;
```

Sind alle Arbeiten durchgeführt, sollte mit folgenden Befehl vom Host auf den MySQL Server, im Docker Container, zugegriffen werden können:
```Shell
    $ mysql -u root -p admin -h 127.0.0.1
```


### Container-Networking
***
Bei Docker können "Netzwerke" getrennt von Containern erstellt und verwaltet werden.

Wenn man Container startet, lassen sie sich einem bestehenden Netzwerk zuweisen, sodass sie sich direkt mit anderen Containern im gleichen Netzwerk austauschen können.

Standardmässig werden folgende Netzwerke eingerichtet:
* bridge 
    * Das Standard-Netzwerk indem gemappte Ports gegen aussen sichtbar sind.
* none
    * Für Container ohne Netzwerkschnittstelle bzw. ohne Netzanbindung.
* host
    * Fügt den Containern dem internen Host-Netzwerk hinzu, Ports sind nicht nach aussen sichtbar.

**Befehle** <br>

Auflisten der bestehenden Netzwerke:
```Shell
    $ docker network ls
```

Detailinformationen, inkl. der Laufenden Container zu einem Netzwerk:
```Shell
    $ docker network inspect bridge
```

Container erstellen ohne Netzwerkschnittstelle:
```Shell
    $ docker run --network=none -it --name c1 --rm busybox
    
    # Kontrollieren im Container 
    $ ifconfig  
```

Container erstellen mit dem Host-Netzwerk:
```Shell
    $ docker run --network=host -itd --name c1 --rm busybox
    
    # Kontrollieren mittels
    $ docker inspect host
```

Erstellen eines neuen Brigde-Netzwerk:
```Shell
    $ docker network create --driver bridge isolated_nw
```

Vorheriges MySQL- & Ubuntu-Beispiel starten und mit neuem Bridge-Netzwerk verbinden:
```Shell
    $ docker run --rm -d --network=isolated_nw --name mysql mysql
    $ docker run -it --rm --network=isolated_nw --name ubuntu ubuntu:14.04 bash
```

Im Ubuntu Container, Verbindung zum MySQL Server Port überprüfen:
```Shell
    $ sudo apt-get update && sudo apt-get install -y curl
    $ curl -f http://mysql:3306
```

**Container-Linking (veraltet)** <br>
Docker-Links sind die einfachste Möglichkeit, Container auf dem gleichen Host miteinander reden lassen zu können. Nutzt man das Standardnetzwerk-Modell von Docker, geschieht die Kommunikation zwischen Containern über ein internes Docker-Netzwerk, so dass sie nicht im Host-Netzwerk erreichbar sind.

Beispiel:
```Shell
    $ docker run -it --rm --link mysql:mysql ubuntu:14.04 bash
```

Innerhalb des MySQL-Containers:
```Shell
    env

    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    HOSTNAME=53a8e2acc32c
    MYSQL_PORT=tcp://172.17.0.2:3306
    MYSQL_PORT_3306_TCP=tcp://172.17.0.2:3306
    MYSQL_PORT_3306_TCP_ADDR=172.17.0.2
    MYSQL_PORT_3306_TCP_PORT=3306
    MYSQL_PORT_3306_TCP_PROTO=tcp
    MYSQL_NAME=/tender_feynman/mysql
    HOME=/root

    sudo apt-get update && sudo apt-get install -y curl mysql-client    
```

Testen ob der Port aktiv ist (auf Ubuntu):
```Shell
    $ curl -f http://${MYSQL_PORT_3306_TCP_ADDR}:${MYSQL_PORT_3306_TCP_PORT}
```

MySQL Client starten (auf Ubuntu):
```Shell
    $  mysql -u root -p admin -h ${MYSQL_PORT_3306_TCP_ADDR}
```



![](../images/Volume_36x36.png?raw=true "Volumes") 04 - Volumes
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Bis jetzt gingen alle Änderungen im Dateisystem beim Löschen des Docker Containers komplett verloren.

Um Daten persistent zu halten, stellt Docker verschiedene Möglichkeiten zur Verfügung:
* Ablegen der Daten auf dem Host
* Sharen der Daten zwischen Container
* Eigene, sogenannte Volumes erstellen, zum Ablegen von Daten

**Erweiterung im Dockerfile** <br>
Um Daten auf dem Host oder in Volumes zu speichern, sind die Verzeichnis mit den Daten via `VOLUME` im Dockerfile einzutragen.

Beispiel MySQL:
```Shell
    VOLUME /var/lib/mysql
```


### Volumes
***
Volumes sind ein spezielles Verzeichnis auf dem Host in dem einer oder mehrere Container ihre Daten ablegen.

Volumes bieten mehrere nützliche Funktionen für persistente oder gemeinsam genutzte Daten:
* Volumes werden initialisiert, wenn ein Container erstellt wird.
* Wenn das Image des Containers, Daten am angegebenen Einhängepunkt enthält, werden die vorhandenen Daten nach der Volumeninitialisierung in das neue Volume kopiert.
* Volumes können gemeinsam genutzt und unter Containern wiederverwendet werden.
* Änderungen an einem "Data volumes" erfolgen direkt.
* Änderungen an einem "Data volumes" werden nicht berücksichtigt, wenn Sie ein Image aktualisieren.
* Volumes bleiben bestehen, auch wenn der Container selbst gelöscht wird.
* Volumes sind so ausgelegt, dass die Daten unabhängig vom Lebenszyklus des Containers bestehen bleiben.
* Docker löscht nie automatisch Volumes, wenn Sie einen Container entfernen, kann deshalb "Müll" übrigbleiben

**Beispiele** <br>
Busybox Container starten und neues Volume `/data` anlegen:
```Shell
    $ docker run --network=host -it --name c2 -v /data --rm busybox
    
    # Im Container
    $ cd /data
    $ mkdir t1
    $ echo "Test" >t1/test.txt
    
    # CTRL + P + CTRL + Q
    $ docker inspect c2
    
    # Nach Mounts suchen, z.B. 
            "Mounts": [
            {
                "Type": "volume",
                "Name": "ea99634523a0aa3d6fbf7ee02c491029170d7105f9c5404760a71e046ad55c67",
                "Source": "/var/lib/docker/volumes/ea99634523a0aa3d6fbf7ee02c491029170d7105f9c5404760a71e046ad55c67/_data",
                "Destination": "/data",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
    
    # Datei ausgeben (auf Host)
    $ sudo cat /var/lib/docker/volumes/ea99634523a0aa3d6fbf7ee02c491029170d7105f9c5404760a71e046ad55c67/_data/t1/test.txt
```

Datenverzeichnis `/var/lib/mysql` vom Container auf dem Host einhängen (mount):
```Shell
    $ docker run -d -p 3306:3306  -v ~/data/mysql:/var/lib/mysql --name mysql --rm mysql
    
    # Datenverzeichnis
    $ ls -l ~/data/mysql
```

Einzelne Datei auf dem Host einhängen:
```Shell
    $ docker run --rm -it -v ~/.bash_history:/root/.bash_history ubuntu /bin/bash
```


### Datencontainer
***
Früher wurden Datencontainer erstellt, deren einziger Zweck das gemeinsame Nutzen von Daten durch andere Container war.

Dazu musste zuerst ein Container via `docker run` gestartet werden, damit andere via `--volumes-from` darauf zugreifen konnten.

Diese Methode war zwar funktionsfähig aber nicht ausbaufähig.
 
**Beispiel** <br>
Container mit Datencontainer `dbdata` erstellen:
```Shell
    $ docker create -v /dbdata --name dbstore busybox 
```

Zweiten Container erstellen, welcher auf den Datencontainer `dbdata` zugreift:
```Shell
    $  docker run -it --volumes-from dbstore --name db busybox
    
    # Im Container
    $ ls -l /dbdata
```

Der Datencontainer `dbdata` ist nun unter dem root-Verzeichnis als `/dbdata` eingehängt.


### Named Volumes
***
Seit der Version 1.9 von Docker existiert das Kommando `docker volume` zur Verwaltung von Volumes auf einem Docker Host:
* Man kann damit verschiedene Volume-Driver-Dateisysteme für Container bereitstellen.
* Ein Volume kann nun auf einem Host angelegt werden und dem verschiedenen Container bereitgestellt werden.
* Volumes können einheitlich mit diesen Befehlen verwaltet werden.
* Wenn keine Default-Dateien auf dem Volume benötigt werden, kann auf einen separaten Datencontainer verzichtet werden.
* Mit diesem Schritt können nun verschiedene Dateisysteme und Optionen effizient in Containern genutzt werden.

**Beispiele** <br>
Erstelle eine Volume `mysql`:
```Shell
    $ docker volume create mysql
```

Ausgabe aller vorhandenen Volumes:
```Shell
    $ docker volume ls
```

Erstellt einen Container `c2` und hängt das Volume unter `/var/lib/mysql` ein:
```Shell
    $ docker run  -it --name c2 -v mysql:/var/lib/mysql --rm busybox
```

Die Abhängigkeit Volume Verzeichnis kann auch im Dockerfile hinterlegt werden:
```Shell
    VOLUME mysql:/var/lib/mysql
```



![](../images/Share_36x36.png "Image-Bereitstellung") 05 - Image-Bereitstellung
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Hat man eigene Images erstellt, werden kann man sie auch für andere bereitstellen – sei es für Kollegen, auf Continuous-Integration-Servern oder für Endanwender.

Es gibt viele verschiedene Möglichkeiten, Images bereitzustellen: Man kann sie aus Dockerfiles neu bauen, aus einer Registry `docker pull` ziehen oder sie mit `docker load` aus einer Archivdatei installieren.

**Namensgebung für Images** <br>
Images bestehen aus Namen und Version (TAG), z.B. ubuntu:16.04. Wird keine Version Angegeben wird automatisch :latest angefügt.

Beim Bereitstellen von Images ist es sehr wichtig, beschreibende und exakte Namen und Tags einzusetzen.

Imagenamen und -Tags werden beim Bauen der Images oder durch den Befehl `docker tag` gesetzt:
```Shell
    $ docker build -t mysql .
    $ docker build -t mysql:1.0 .
    $ docker tag mysql username/mysql 
```

Die Tag-Namen müssen sich an ein paar Regeln halten. Sie müssen aus Gross- und Kleinbuchstaben, Zahlen oder den Symbolen . und - bestehen. Sie dürfen nicht länger als 128 Zeichen sein. Beim ersten Zeichen darf es sich nicht um ein . oder - handeln.

Namen von Repositories und Tags sind ausgesprochen wichtig, wenn man einen Entwicklungs-Workflow aufbauen möchte. Docker hat nur sehr wenige Regeln für gültige Namen und erlaubt es jederzeit, Namen zu erstellen oder zu löschen. Es liegt also am Entwicklungsteam, ein vernünftiges Namensschema zu entwerfen und umzusetzen.

**Warnung vor dem latest-Tag** <br>
Docker nutzt `latest` als Standardwert, wenn kein Tag vergeben wurde, darüber hinaus hat es aber keine spezielle Bedeutung. Viele Repositories verwenden es als Alias für das aktuellste stabile Image, dabei handelt es sich aber nur um eine Konvention, die durch keinerlei technische Massnahmen erzwungen wird.

Bezieht sich ein `docker run` oder `docker pull` auf einen Imagenamen ohne Tag, wird Docker das Image verwenden, das mit latest gekennzeichnet ist. Gibt es kein solches Image, wird ein Fehler ausgegeben.


### Docker Hub
***
Die einfachste Möglichkeit, eigene Images bereitzustellen, ist der Einsatz des Dockers Hub.

Bei diesem handelt es sich um die von Docker Inc. angebotene Online-Registry.

Der Hub ermöglicht kostenlose Repositories für öffentliche Images, die Anwender können aber auch für private Repositories bezahlen.

**Docker Hub einrichten** <br>
Um seine eigenen Images auf Docker Hub hochzuladen ist wie folgt vorzugehen: 
1. Acount auf Docker Hub eröffnen.
2. Imagenamen mit Usernamen, laut Account auf Docker Hub, taggen:
    ```Shell
        $ docker tag mysql username/mysql
    ```
3. Image hochladen:
    ```Shell
        $ docker push username/mysql
    ```
4. Dashboard auf Docker Hub anwählen und Image beschreiben.

**Weitere Befehle** <br>

Suchen nach Images auf Docker Hub:
```Shell
    $ docker search mysql
```

Image herunterladen, z.B. um Build-Zeiten zu vermindern:
```Shell
    $ docker pull ubuntu
```


### Export/Import von Container und Images 
***
Um Container und Images einfach nur zwischen verschiedenen Hosts hin und her zu verschieben, wird keine Registry benötigt.

Container können mittels `docker export` und `docker import` und Images mittels `docker save` und `docker load` von/nach Verzeichnisse kopiert werden.

**Container** <br>

Container exportieren:
```Shell
    $ docker ps

        CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
        7fd371d71357        vagrant_apache      "/bin/sh -c '/bin/..."   3 hours ago         Up 3 hours          0.0.0.0:8080->80/tcp   vagrant_apache_1

    $ docker export vagrant_apache_1 -o va1.tar

    $ ls -lh

        total 200M
        -rwxrwxrwx 1 ubuntu ubuntu  731 Feb  2 08:28 Dockerfile
        -rwxrwxrwx 1 ubuntu ubuntu 200M Feb  2 12:36 va1.tar
```

Container importieren, z.B. auf einem anderen Host (dabei wir ein Image erzeugt):
```Shell
    $ docker import va1.tar va1

    $ docker images

        REPOSITORY          TAG                 IMAGE ID            CREATED                  SIZE
        va1                 latest              167ec5ca640c        Less than a second ago   200 MB
```

**Images** <br>

Eigene Images ausgeben:
```Shell
    /vagrant/mysql$ docker images

        REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
        mysql               latest              24be8efe0428        2 hours ago         346 MB
        apache              latest              4221b4f12ce8        2 hours ago         225 MB

```

Images im TAR-Format mit `save` sichern:
```Shell
    /vagrant/mysql$ docker save mysql -o mysql.tar
    /vagrant/mysql$ docker save apache -o apache.tar
```

Images mit `load` wiederherstellen:
```Shell
    $ docker load -i mysql.tar  
```

### Private Registry 
***
Es gibt neben dem Docker Hub noch ein paar weitere Möglichkeiten.

Mann könnte alles manuell machen, indem Images exportiert und wieder importiert oder einfach auf jedem Docker Host aus Dockerfiles neue Images gebaut werden.

Beide Lösungen sind suboptimal: <br>
Das immer neue Bauen aus Dockerfiles ist langsam und kann auf den verschiedenen Hosts zu unterschiedlichen Images führen, während das Exportieren und Importieren von Images knifflig und fehleranfällig sein kann.

Die verbleibende Möglichkeit ist, eine andere Registry zu verwenden, die entweder von einem selbst oder durch eine andere Firma gehostet werden kann.

**Private Docker Registry einrichten** <br>
```Shell
    $ sudo docker pull registry:2
    
    $ sudo docker run -d -p 5000:5000 --restart=always --name registry \ 
    -v /var/spool/docker-registry:/var/lib/registry registry:2
```

**Docker Client auf Registry zusteuern** <br>
Die Docker Clients steuern per default auf Docker Hub zu. Damit sie mit der lokalen Registry arbeiten kann, ist die Datei `/etc/docker/daemon.json` mit folgendem Inhalt zu erstellen und Docker neu zu starten (`sudo docker restart`):

```Shell
    { "insecure-registries":["{{config.docker}}:5000"] }
```

Anschliessend können die vorhanden Images von unserer lokalen Docker Registry geholt werden (pull):
```Shell
    $ docker pull {{config.docker}}:5000/ubuntu
```

(...) oder geschrieben werden (push):
```Shell
    $ docker tag ubuntu {{config.docker}}:5000/myubuntu
    $ docker push {{config.docker}}:5000/myubuntu
```

**Wichtig:** `{{config.docker}}` durch installierten Server ersetzen.

![](../images/Reflexion_36x36.png "Fazit / Reflexion") 06 - Reflexion
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

![](../images/Samples_36x36.png "Docker") 09 - Beispiele (für LB3)
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

1.  Terminal (*Bash*) öffnen
2.  [VM (beinhaltet Docker)](../docker/) erstellen und darin wechseln

```Shell
    cd M300/docker
    vagrant up
    vagrant ssh
```

3.  In der VM ins Verzeichnis `/vagrant<Beispiel>` wechseln und `README.md` studieren, z.B. mittels `less README.md`.

Es stehen folgende Beispiele zur Verfügung:

* [apache - Apache Web Server](../docker/apache/)
* [mysql - MySQL Datenbank](../docker/mysql/)
* [apache4X - Scriptscript welches 4 Web Server Container erstellt](../docker/apache4X/)
* [compose - Docker Compose](../docker/compose/)
* [dotnet - .NET Entwicklungsumgebung](d../docker/otnet/)
* [microservice - Micro Service mit Node.js](../docker/microservice/)
* [jenkins - Build (CI/CD) Umgebung](../docker/jenkins/)


![](../images/Magnifier_36x36.png "Quellenverzeichnis") 10 - Quellenverzeichnis
======

> [⇧ **Nach oben**](#inhaltsverzeichnis) 
