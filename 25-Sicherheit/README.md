M300 - 25 Infrastruktur-Sicherheit 
======

Diese Wikiseite zeigt verschiedene Möglichkeiten auf, wie eine virtualisierte Infrastruktur in Punkto Sicherheit verbessert werden kann.

#### Lernziele

Sie können die Sicherheit in einer virtualisierte Infrastruktur Verbessern.

#### Voraussetzungen
* [10 Toolumgebung](../10-Toolumgebung/)
* [20 Virtualisierte Infrastruktur](../20-Infrastruktur/)

#### Inhaltsverzeichnis

* 01 - [Firewall & Reverse Proxy](#-01---firewall--reverse-proxy)
* 02 - [Benutzer- & Rechteverwaltung (optional)](#-02---benutzer---rechteverwaltung)
* 03 - [SSH](#-03---ssh)
* 04 - [Authentifizierung & Autorisierung (optional)](#-04---authentifizierung--autorisierung)
* 05 - [Reflexion](#-05---reflexion)
* 06 - [Fragen](Fragen.md)
* 08 - [Quellenverzeichnis](#-08---quellenverzeichnis)
* 09 - [Beispiele](#-09---beispiele)

___

![](../images/Firewall_36x36.png "Cloud Computing") 01 - Firewall & Reverse Proxy
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Bis jetzt sind alle Services ungehindert Zugreifbar. Würden wir eine VM direkt in das Internet oder in eine DMZ stellen, hätten wir ein grösseres Sicherheitsproblem. Um das zu verhindern sperren wir nicht-öffentliche Ports mittels einer Firewall und verschlüsseln den restlichen Datenverkehr mit einem Reverse Proxy.

**Firewall** <br>
Eine Firewall ist ein Sicherungssystem, welches ein Rechnernetz oder einen einzelnen Computer vor unerwünschten Netzwerkzugriffen schützt und weiter gefasst auch ein Teilaspekt eines Sicherheitskonzepts ist.

Jedes Firewall-Sicherungssystem basiert auf einer Softwarekomponente. Die Firewall-Software dient dazu, den Netzwerkzugriff zu beschränken, basierend auf Absender- oder Zieladresse und genutzten Diensten. Sie überwacht den durch die Firewall laufenden Datenverkehr und entscheidet anhand festgelegter Regeln, ob bestimmte Netzwerkpakete durchgelassen werden oder nicht. Auf diese Weise versucht sie, unerlaubte Netzwerkzugriffe zu unterbinden.

**Reverse Proxy**
Der Reverse Proxy ist ein Proxy, der Ressourcen für einen Client von einem oder mehreren Servern holt. Die Adressumsetzung wird in der entgegengesetzten Richtung vorgenommen, wodurch die wahre Adresse des Zielsystems dem Client verborgen bleibt. Während ein typischer Proxy dafür verwendet werden kann, mehreren Clients eines internen (privaten – in sich geschlossenen) Netzes den Zugriff auf ein externes Netz zu gewähren, funktioniert ein Reverse Proxy genau andersherum.


### UFW Firewall
***
UFW steht für `Uncomplicated Firewall`. Ziel von UFW ist es, ein unkompliziertes Kommandozeilen-basiertes Frontend für das sehr leistungsfähige, aber nicht gerade einfach zu konfigurierende iptables zu bieten. UFW unterstützt sowohl IPv4 als auch IPv6.

**Ausgabe der offenen Ports**
```Shell
    $ netstat -tulpen
```

**Installation**
```Shell
    $ sudo apt-get install ufw
```

**Start / Stop**
```Shell
    $ sudo ufw status
    $ sudo ufw enable
    $ sudo ufw disable
```

**Firewall-Regeln**
```Shell
    # Port 80 (HTTP) öffnen für alle
    vagrant ssh web
    sudo ufw allow 80/tcp
    exit

    # Port 22 (SSH) nur für den Host (wo die VM laufen) öffnen
    vagrant ssh web
    w
    sudo ufw allow from [Meine-IP] to any port 22
    exit

    # Port 3306 (MySQL) nur für den web Server öffnen
    vagrant ssh database
    sudo ufw allow from [IP der Web-VM] to any port 3306
    exit
```

**Zugriff testen**
```Shell
    $ curl -f 192.168.55.101
    $ curl -f 192.168.55.100:3306
```

**Löschen von Regeln**
```Shell
    $ sudo ufw status numbered
    $ sudo ufw delete 1
```

**Ausgehende Verbindungen** <br>
Ausgehende Verbindungen werden standardmässig erlaubt.

Werden keine Ausgehenden Verbindungen benötigt oder nur bestimmte (z.B. ssh) können zuerst alle geschlossen und dann einzelne Freigeschaltet werden.

```Shell
    $ sudo ufw deny out to any
    $ sudo ufw allow out 22/tcp 
```


### Reverse Proxy
***
Der Apache-Webserver kann auch als Reverse Proxy eingerichtet werden. 

**Installation**
Dazu müssen folgende Module installiert werden:
```Shell
    $ sudo apt-get install libapache2-mod-proxy-html --> ist schon im apache2-bin enthalten
    $ sudo apt-get install libxml2-dev
```

Anschliessend die Module in Apache aktivieren:
```Shell
    $ sudo a2enmod proxy
    $ sudo a2enmod proxy_html
    $ sudo a2enmod proxy_http 
```

Die Datei /etc/apache2/apache2.conf wie folgt ergänzen:
```Shell
    ServerName localhost 
```

Apache-Webserver neu starten:
```Shell
    $ sudo service apache2 restart
```

**Konfiguration** <br>
Die Weiterleitungen sind z.B. in `sites-enabled/001-reverseproxy.conf` eingetragen:
```Shell
    # Allgemeine Proxy Einstellungen
    ProxyRequests Off
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

    # Weiterleitungen master
    ProxyPass /master http://master
    ProxyPassReverse /master http://master
```


![](../images/Benutzer-_und_Rechteverwaltung_36x36.png "Benutzer- & Rechteverwaltung") 02 - Benutzer- & Rechteverwaltung
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

**Benutzer** <br>
Linux kennt als Multiuser-Betriebssystem - wie alle unixoiden Betriebssysteme - das Konzept verschiedener Benutzer. Diese haben nicht alle unbedingt dieselben Rechte und Privilegien.

Neben den eigentlichen Benutzerkonten für reale Personen existieren auf dem System noch viele Systemdienste mit einem eigenen Benutzerkonto. Dadurch wird erreicht, dass eine mögliche Schwachstelle in einem Dienst nicht zu grosse Auswirkungen auf das System haben kann.

| Benutzername  | Funktion                                             |
| ------------- | ---------------------------------------------------- | 
| `root`        | Der Systemverwalter unter Linux                      |
| `nobody`      | Wird von Prozessen als Benutzererkennung verwendet, wenn nur ein Minimum an Rechten vergeben werden soll  |
| `cupsys`      | Benutzer des Druckdienstes CUPS                      |
| `www-data`    | Benutzer des Webservers Apache                       |


Die Benutzer stehen in der Datei `/etc/passwd`. Die Passwörter in der Datei `/etc/shadow`.

Der Systemverwalteraccount "root" hat alle Rechte. Da dieser kein Password besitzt kann mit diesem nicht eingeloggt werden. Sollen Befehle mit "root" durchgeführt werden, ist sudo voranzustellen.

Beispiele:
```Shell
    $ sudo apt-get update
    $ sudo apt-get -y install apache2
```

**Wichtig:** Wer und wie (z.B. mit/ohne Password) ein Benutzer sudo verwenden kann steht in der Datei `/etc/sudoers` bzw. im Verzeichnis `/etc/sudoers.d`.

**Gruppen** <br>
Jeder Benutzer ist einer Hauptgruppe zugeordnet, kann daneben aber auch Mitglied weiterer Gruppen sein. Der Zugriff auf gewisse Hardware oder Dienste ist auf die Mitglieder einer bestimmten Gruppe beschränkt. So dürfen z.B. nur Benutzer, die zur Gruppe "audio" gehören, Klänge über die Soundkarte ausgeben. Möchte man nun einem Benutzer die Berechtigung für die Soundkarte geben, so erreicht man dies, indem man ihn in die Gruppe "audio" aufnimmt.

Die Gruppen stehen in der Datei `/etc/group`.


### Homeverzeichnis
***
Das Homeverzeichnis ist der Ort, an dem Benutzer ihre Daten ablegen können und an dem Programme ihre benutzerspezifischen Einstellungen hinterlegen. Nur hier hat der einzelne Benutzer volle Schreib- und Leserechte. Und nur hier sollten Benutzer ihre Daten speichern.

Das Homeverzeichnis setzt sich aus `/home` und dem jeweiligen Benutzernamen zusammen (z.B. /home/myaccount)

Einstellungen werden üblicherweise in versteckten Dateien und Verzeichnissen gespeichert. Diese erkennt man daran, dass die Namen mit einem Punkt beginnen. `.bashrc` oder `.ssh` sind Beispiele für solche Konfigurationsdateien bzw. -verzeichnisse.

**Das Zeichen "~"**
Oft wird die Kurzform `~/Ordnername` verwendet. Die Tilde **~** steht für eine Shell-Extension, also quasi eine Abkürzung, die immer auf /home/BENUTZERNAME/ verweist. Heisst der Benutzer also z.B. db01 wird ~ durch /home/db01/ ersetzt.

**Login-Prozess**
Beim Einloggen eines Users werden folgende Konfigurationen durchlaufen:
* /etc/profile.d
* ~/.profile
* ~/.bashrc

Im Verzeichnis `/etc/profile.d` stehen Einstellungen für alle Benutzer. 


### Dateisystem
***
Dateisysteme sind die Schnittstellen zwischen dem Betriebssystem und den Partitionen auf Datenträgern. Sie organisieren die geordnete Ablage von Daten.

Neben der Datenorganisation auf dem Datenträger kann ein Dateisystem noch zusätzliche Möglichkeiten zur Verfügung stellen. Zum Beispiel:
* Verzeichnisse und Unterverzeichnisse anlegen
* Datumsinformationen speichern (Erstellungsdatum, letzte Änderung, Zugriff)
* Lange Dateinamen verwenden
* Gross- und Kleinschreibung für Dateinamen berücksichtigen
* Sonderzeichen für Dateinamen ermöglichen (z.B. Leerzeichen)
* Rechteverwaltung zur Zugriffssteuerung auf Dateien bzw. Verzeichnisse
* Journaling-Funktionen

**Hinweis:** <br> 
> Gross- & Kleinschreibung von Ordnern und Dateien wird unter Linux – im Gegensatz zu Windows – berücksichtigt. 
> Beispiel.doc und beispiel.doc sind zwei unterschiedliche Dateien.

**Dateieigenschaften**
UNIX-Systeme (z.B. Linux) verwalten ihre Dateien in einem virtuellen Dateisystem (VFS, Virtual File System). Dieses ordnet jeder Datei über eindeutig identifizierbare Inodes unter anderem folgende Eigenschaften zu:
* Dateityp (einfache Datei, Verzeichnis, Link, etc.)
* Zugriffsrechte (Eigentümer-, Gruppen- und sonstige Rechte)
* Grösse
* Zeitstempel
* Verweis auf Dateiinhalt

**Rechte**
Zugriffsrechte regeln, welcher Benutzer und welche Gruppe den Inhalt eines Verzeichnisses (ein Verzeichnis ist auch nur eine Datei) lesen, schreiben oder ausführen darf. Zum Beispiel:
```Shell
    $ ls -ldh /var/mail
    
    drwxrwsr-x 2 root mail 4.0K Jan 19 15:50 /var/mail
```

Der erste Buchstabe kennzeichnet den Dateityp (**d** = directory / **-** = file). Danach folgen die Zugriffsrechte.

Wenn man die Zugriffsrechten im vorherigen Beispiel in Dreiergruppen unterteilt erhält man die Rechte:
* rwx: Rechte des Eigentümers
* rws: Rechte der Gruppe
* r-x: Recht von allen anderen (others)

Die Bedeutung der Buchstaben sind wie folgt:
* **r** - Lesen (read): 
    * Erlaubt lesenden Zugriff auf die Datei. Bei einem Verzeichnis können damit die Namen der enthaltenen Dateien und Ordner abgerufen werden (nicht jedoch deren weitere Daten wie z.B. Berechtigungen, Besitzer, Änderungszeitpunkt, Dateiinhalt etc.).
* **w** - Schreiben (write): 
    * Erlaubt schreibenden Zugriff auf eine Datei. Für ein Verzeichnis gesetzt, können Dateien oder Unterverzeichnisse angelegt oder gelöscht werden, sowie die Eigenschaften der enthaltenen Dateien bzw, Verzeichnisse verändert werden.
* **x** - Ausführen (execute): 
    * Erlaubt das Ausführen einer Datei, wie das Starten eines Programms. Bei einem Verzeichnis ermöglicht dieses Recht, in diesen Ordner zu wechseln und weitere Attribute zu den enthaltenen Dateien abzurufen (sofern man die Dateinamen kennt ist dies unabhängig vom Leserecht auf diesen Ordner). Statt x kann auch ein Sonderrecht angeführt sein.
* **s** -Set-UID-Recht (SUID-Bit): 
    * Das Set-UID-Recht ("Set User ID" bzw. "Setze Benutzerkennung") sorgt bei einer Datei mit Ausführungsrechten dafür, dass dieses Programm immer mit den Rechten des Dateibesitzers läuft. Bei Ordnern ist dieses Bit ohne Bedeutung.
* **s** (S) Set-GID-Recht (SGID-Bit): 
    * Das Set-GID-Recht ("Set Group ID" bzw. "Setze Gruppenkennung") sorgt bei einer Datei mit Ausführungsrechten dafür, dass dieses Programm immer mit den Rechten der Dateigruppe läuft. Bei einem Ordner sorgt es dafür, dass die Gruppe an Unterordner und Dateien vererbt wird, die in diesem Ordner neu erstellt werden.
* **t** (T) Sticky-Bit: 
    * Das Sticky-Bit hat auf modernen Systemen nur noch eine einzige Funktion: Wird es auf einen Ordner angewandt, so können darin erstellte Dateien oder Verzeichnisse nur vom Dateibesitzer gelöscht oder umbenannt werden. Verwendet wird dies z.B. für /tmp.

Folgende Befehle dienen zum ändern der Rechte:

| Befehl        | Funktion                                             |
| ------------- | ---------------------------------------------------- | 
| `chmod`       | Dient zum Setzen der Dateirechte                     |
| `chown`       | Dient zum Ändern des Dateibesitzers                  |
| `chgrp`       | Dient zum Ändern der Gruppe einer Datei              |


![](../images/SSH_36x36.png "SSH") 03 - SSH
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Es gab einmal eine Zeit, als Computer im Netz über das Telnet-Protokoll zugänglich waren. Da dieses Protokoll keine Verschlüsselung bot, wurde das Mitschneiden von Passwörtern zur trivialen Angelegenheit.

Um den Fernzugang zu sichern, schrieb Tatu Ylönen Mitte der 1990er eine Programmsuite – bestehend aus Server-, Client- und Hilfsprogrammen – die er SSH (Secure Shell) nannte.

Später gründete Tatu Ylönen die Firma ssh.com und bot die Version 2 der SSH-Suite nur noch kommerziell an. Daraufhin wurde von Entwicklern des Betriebssystems OpenBSD der öffentliche Quellcode der Version 1 geforkt. Sie entwickelten das Programm unter dem Namen "OpenSSH" weiter. Diese OpenSSH-Suite wurde fester Bestandteil quasi aller Linux-Distributionen.

Drei wichtige Eigenschaften führten zum Erfolg von SSH:
* Authentifizierung der Gegenstelle, kein Ansprechen falscher Ziele
* Verschlüsselung der Datenübertragung, kein Mithören durch Unbefugte
* Datenintegrität, keine Manipulation der übertragenen Daten

**Wichtige Befehle** <br>
Entferntes System aufrufen:
```Shell
    $ ssh web01             #Ohne Benutzerangabe
    $ ssh ubuntu@web01      #Mit Benutzerangabe
```

Befehl auf entferntem System ausführen:
```Shell
    $ ssh web01 ls -l
```

Backup mit SSH erstellen:
```Shell
    $ ssh root@server 'cd /etc; tar czvf - network/' | cat > etc_network_backup.tar.gz 
```

Kopieren von Daten von einem System zu einem anderen:
```Shell
    $ scp <datei> <server>:<datei>  
    $ scp <server>:<datei> <datei>
```

Weitere Befehle und Funktionen sind:
* sftp - File Transfer (verschlüsselt)
* sshfs - Entfernte Dateisysteme einbinden


### Public Key Verfahren
***
Wem die Authentifizierung über Passwörter trotz der Verschlüsselung zu unsicher ist, - immerhin könnte das Passwort ja erraten werden - der benutzt am besten das Public-Key-Verfahren.

Hierbei wird asymmetrische Verschlüsselung genutzt, um den Benutzer zu authentifizieren.

Der (oder die) öffentliche(n) Schlüssel des Benutzers befindet sich dabei in der Datei `~/.ssh/authorized_keys` des Zielsystems, der private Schlüssel in einer Datei (meist `id_rsa`) im Verzeichnis `~/.ssh` auf dem lokalen System, wo er zusätzlich von einer "Pass Phrase" geschützt wird.

Wenn man sich nun mit der Public-Key-Methode auf einem SSH-Server anmelden möchte, so schickt der Server dem Client eine zufällig generierte Challenge. Der Client verschlüsselt diesen Datenblock mit seinem privaten Schlüssel, (wofür nötigenfalls die Passphrase abgefragt wird,) und wenn der Server diesen Chiffre mit dem zugehörigen öffentlichen Schlüssel wieder entschlüsseln kann, ist die Identität des Benutzers bestätigt.

**Befehle** <br>
Damit man dieses Verfahren überhaupt verwenden kann, muss man sich zunächst mit Hilfe des Kommandozeilenprogramms ssh-keygen ein entsprechendes Schlüsselpaar erzeugen:
```Shell
    $ vagrant ssh web

    $ sudo su - admin01

    # Key erstellen
    $ ssh-keygen -t rsa -b 4096 
```

Alternative, wenn root die Keys für die User erzeugen soll (z.B. in Vagranfile):
```Shell
    $ su - admin01 -c 
    "mkdir .ssh && chmod 700 .ssh && ssh-keygen -t rsa -f .ssh/id_rsa -b 4096 -C admin01@tbz.ch -P ''"
```

Nun muss noch der öffentliche Schlüssel, zu erkennen an der Endung .pub (id_rsa.pub), auf dem Zielsystem deponiert werden. Dazu dient das Programm ssh-copy-id. Zu diesem Zeitpunkt muss die Authentifizierung per Passwort noch erlaubt sein (PasswordAuthentication yes):
```Shell
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub admin01@db01 
```

Sollte `ssh-copy-id` nicht funktionieren, kann man den öffentlichen Schlüssel auch anders auf das Zielsystem kopieren und in die Datei ~/.ssh/authorized_keys einfügen:
```Shell
    $ cat id_rsa.pub | ssh db01 'cat>> ~/.ssh/authorized_keys' 
```

Anschliessend kann man sich ohne Passwort anmelden:
```Shell
    $ ssh admin01@db01 
```

### SSH Tunnel

Tunnel bzw. Tunneling bezeichnet in einem Netzwerk die Konvertierung und Übertragung eines Kommunikationsprotokolls, das für den Transport in ein anderes Kommunikationsprotokoll eingebettet wird. 

Vor und hinter den Tunnelpartnern wird somit das ursprüngliche Protokoll „gesprochen“, während zwischen den Tunnelpartnern ein anderes Protokoll verwendet wird, das einer anderen Art der Kommunikation dient und dennoch die Daten des ursprünglichen Protokolls transportiert. 

Dafür wird die Tunnelsoftware auf beiden Seiten des Tunnels benötigt. Nachdem sie die ursprünglichen Kommunikationsdaten in ein anderes Protokoll eingebettet hat, muss die Software auf der jeweils anderen Seite des Tunnels die Daten wieder extrahieren und weiterreichen.

**Die Kommunikation im Tunnel erfolgt verschlüsselt!**

### Befehle (mit VMs aus Beispiel `vagrant/user`)

Weiterleitung von Port 8000 auf dem lokalen System (database/db01) an den Webserver web/web01 (192.168.55.101:80):

	cd user
	vagrant ssh database
	# Wechsel auf User admin01
	sudo su - admin01
	# in der VM
	ssh -L 8000:localhost:80 web01 -N &
	netstat -tulpen
	curl http://localhost:8000

Umgekehrte Richtung. Benutzern auf web/web01 wird ermöglicht, über localhost:3307 auf den MySQL-Server auf database/db01 zuzugreifen:

	vagrant ssh database
	# in der VM database
	ssh -R 3307:localhost:3306 web01 -N &
	ssh web01
	# in der VM web
	netstat -tulpen
	curl http://localhost:3307

	
**ACHTUNG:** Der db01 Server muss über einen Privaten SSH-Key verfügen und der Public SSH-Key muss in web01 eingetragen sein. Zusätzlich muss bereits einmal via `ssh` von db01 in den web01 Server gewechselt worden sein.


![](../images/Authentifizierung_und_Autorisierung_36x36.png "Authentifizierung & Autorisierung") 04 - Authentifizierung & Autorisierung
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

**Authentifizierung** <br>
Authentifizierung ist der Nachweis (Verifizierung) einer behaupteten Eigenschaft einer Entität, die beispielsweise ein Mensch, ein Gerät, ein Dokument oder eine Information sein kann und die dabei durch ihren Beitrag ihre Authentisierung durchführt.

Das zugehörige Verb lautet authentifizieren, das für das Bezeugen der Echtheit von etwas steht. In der Informatik wird das substantivierte Wort Authentifizieren häufig sowohl für den Vorgang der Berechtigungssprüfung als auch für das Ergebnis dieser Überprüfung verwendet. Im deutschen Sprachraum wird der Begriff Authentifikation für die Prüfung der Echtheit und der Begriff Authentifizierung für die Bezeugung der Echtheit verwendet.

Die Authentisierung einer Entität bezüglich der behaupteten Eigenschaft der Authentizität, die beispielsweise Einräumen einer "bestehenden Zugangsberechtigung" oder "Echtheit" sein kann, erlaubt der authentifizierten Entität weitere Aktionen. Die Entität gilt dann als authentisch.

Die eine Authentifizierung abschliessende Bestätigung wird auch als Autorisierung bezeichnet, wenn sie durch bestimmte zulässige Modi und/oder in einem bestimmten Kontext eingeschränkt wird. 

**Autorisierung** <br>
Autorisierung ist im weitesten Sinne eine Zustimmung, spezieller die Einräumung von Rechten gegenüber Interessenten, ggf. zur Nutzung gegenüber Dritten. Die Autorisierung überwindet Mechanismen von Sicherungen gegen Unbefugte. Eine Autorisierung hebt keinen Schutz auf. Eine Autorisierung gilt gegebenenfalls eingeschränkt nur in einem Kontext und/oder Modus. Die Autorisierung erfolgt sinnvollerweise nicht ohne eine vorherige erfolgreiche Authentifizierung.

In der IT bezeichnet die Autorisierung das initiale Zuweisen und das wiederholt einleitende Überprüfen von Zugriffsrechten mittels spezieller Methoden bezüglich interessierter Systemnutzer zu Daten und zu Diensten.

Die zwei häufigsten Spezialfälle sind:
* Der erlaubte Zugriff auf sogenannte Ressourcen (z. B. auf Verzeichnisse oder Dateien) in einem Computernetzwerk
* Die Erlaubnis zur Installation oder Benutzung von Computerprogrammen (Software)


### Apache sichern
***
Das Hypertext Transfer Protocol Secure (HTTPS) ist ein Kommunikationsprotokoll im Internet (WWW), um Daten abhörsicher zu übertragen. Technisch definiert es als eine zusätzliche Schicht zwischen HTTP und TCP.

Der aktuelle Apache-Webserver ist in der aktuellen Version bereits für HTTPS vorbereitet.

**HTTPS freischalten** <br>
```Shell
    # Default Konfiguration in /etc/apache2/sites-available freischalten (wird nach sites-enabled verlinkt)
    sudo a2ensite default-ssl.conf

    # SSL Modul in Apache2 aktivieren
    sudo a2enmod ssl

    # Optional HTTP deaktivieren
    sudo a2dissite 000-default.conf 

    # Datei /etc/apache2/ports.conf editieren und <Listen 80> durch Voranstellen von # deaktivieren
    sudo nano /etc/apache2/ports.conf

    # Apache Server frisch starten
    sudo service apache2 restart
```

**User/Password Authentisierung aktivieren** <br>
```Shell
    # .htpasswd Datei erzeugen (ab dem zweiten User ohne -c), Password wird verlangt                        
    sudo htpasswd -c /etc/apache2/.htpasswd guest

    # /etc/apache2/sites-enabled/default-ssl.conf Editieren und vor </VirtualHost> folgendes Einfügen
    <Directory "/var/www/html">
            AuthType Basic
            AuthName "Restricted Content"
            AuthUserFile /etc/apache2/.htpasswd
            Require valid-user
    </Directory>
```


### LDAP
***
LDAP basiert auf dem Client-Server-Modell und kommt bei sogenannten Verzeichnisdiensten (Directories Services) zum Einsatz.

Es beschreibt die Kommunikation zwischen dem LDAP-Client und dem Verzeichnis-(Directory-)Server.

Aus einem solchen Verzeichnis können objektbezogene Daten, wie zum Beispiel Personendaten oder Rechnerkonfigurationen, ausgelesen werden.

Die Kommunikation erfolgt auf Basis von Abfragen.

Das Verzeichnis kann beispielsweise ein Adressbuch enthalten: In seinem E-Mail-Client stösst ein Nutzer die Aktion Suche die Mailadresse von User Joe an. Der E-Mail-Client formuliert eine LDAP-Abfrage an das Verzeichnis, das die Adressinformationen bereitstellt. Das Verzeichnis formuliert die Antwort und übermittelt sie an den Client: joe.doe@example.org.

Mittlerweile hat sich im administrativen Sprachgebrauch eingebürgert, dass man von einem LDAP-Server spricht. Damit meint man einen Directory-Server, dessen Datenstruktur der LDAP-Spezifikation entspricht und der über das LDAPv3-Protokoll Daten austauschen kann.

**Beispiel** <br>
Im Verzeichnis ldap befindet ein Vagrantfile welcher OpenLDAP mit UI (http://localhost:8081/phpldapadmin) auf der Master VM installiert.

Einloggen mittels:
* Login DN: cn=admin,dc=nodomain
* Password: admin
  
Anschliessend können Einträge im LDIF-Format importiert werden, z.B.:

Posix-Gruppe, entspricht Eintrag in `/etc/group`:
```Shell
    dn: cn=apache2,dc=nodomain
    cn: apache2
    gidnumber: 500
    objectclass: posixGroup
    objectclass: top
```

Posix Account, entspricht Eintrag in `/etc/passwd`:
```Shell
    dn: cn=Muster,cn=apache2,dc=nodomain
    cn:  Muster
    gidnumber: 500
    homedirectory: /home/users/Muster
    loginshell: /bin/sh
    objectclass: inetOrgPerson
    objectclass: posixAccount
    objectclass: top
    sn: Muster
    uid: muster
    uidnumber: 1000
    userpassword: {MD5}9WGq9u8L8U1CCLtGpMyzrQ==
```

Anschliessend ist der Apache-Webserver so zu konfigurieren, dass `User/Password` via LDAP geholt werden.

Dazu ist die Datei `/etc/apache2/apache2.conf` wie folgt zu Erweitern:
```Shell
    <Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride None
        #Require all granted
        Order deny,allow
        Deny from All
        AuthName "Company.com Intranet"
        AuthType Basic
        AuthBasicProvider ldap
        #AuthzLDAPAuthoritative off
        AuthLDAPUrl ldap://localhost/dc=nodomain?uid
        Require valid-user
        Satisfy any
    </Directory>
```

Nach den dem Restart von Apache mittels `service apache2 restart`, erscheint eine Loginmaske auf http://localhost:8081 wo man sich mittels Username `muster` und Password `xxx` am Webserver anmelden kann.

**Befehle** <br>
Ausgabe Server Informationen
```Shell
    $ slapcat
```

Ausgabe aller Entries im LDAP Server
```Shell
    $ ldapsearch -x -LLL -H ldap:/// -b dc=nodomain dn
```

Aufbereiten der Klassendatei aus Microsoft Office 365 im LDIF Format.

Dazu muss die Klassendatei wie folgt aufbereitet und im CSV Format (mit Strichpunkt als Trennzeichen) gespeichert sein:
```Shell
    Name      Vorname   Ablageort                             Username
    Muster    Hans      git@gitlab.com:hmuster/M300.git       hmuster

    sed -n '1,$p' test.csv | awk -F";" 'BEGIN { i=1002 }
                                                { print "dn: cn="$4",cn=apache2,dc=nodomain\n" \
                                                    "changetype: add\n"\
                                                    "cn: " $4"\n"\
                                                    "gidnumber: 500\n"\
                                                    "homedirectory: /home/users/"$4"\n"\
                                                    "loginshell: /bin/sh\n"\
                                                    "objectClass: inetOrgPerson\n"\
                                                    "objectClass: posixAccount\n"\
                                                    "objectClass: top\n"\
                                                    "sn: " $1"\n"\
                                                    "uid: " $3"\n"\
                                                    "userpassword: {MD5}9WGq9u8L8U1CCLtGpMyzrQ=="
                                                    print "uidnumber: " i++ "\n"
                                                    }' >adressen.ldif
    ldapadd -x -D "cn=admin,dc=nodomain" -w admin -f adressen.ldif
    
```


### Identitätsmanagement
***
Als Identitätsmanagement (IdM) wird der zielgerichtete und bewusste Umgang mit Identität, Anonymität und Pseudoanonymität bezeichnet. Der Personalausweis ist ein Beispiel für eine staatlich vorgegebene Form der Identifizierung.

Durch die Vernetzung über das Internet hat die Frage von bewusster Anonymität bzw. bewusstem Umgang mit Teilen der eigenen Identität eine neue und zuvor nie gekannte Komplexitätsstufe erreicht.

Im Internet wird regelmässig mit (Teil-)Identitäten gespielt. Es gibt aber auch ernsthafte Prozesse und Fragen der Anonymität im Internet und der Identifizierbarkeit. In vielerlei Hinsicht können Identitätsmanagementsysteme problematisch sein, wenn nicht klar ist, was mit den Daten geschieht, die ggf. ungewollt zu weitergehender Identifizierung führen können.

In der realen wie in der digitalen Welt gibt es verschiedenste Formen des Identitätsmanagements. Gemäss ISO/IEC JTC 1/SC 27/WG 5 "A framework for IdM" umfasst IdM:
* Den Identifikationsprozess einer Einheit (inkl. optionaler Authentisierung)
* Die Information, die mit der Identifikation einer Einheit innerhalb eines bestimmten Kontexts verbunden ist
* Die sichere Verwaltung von Identitäten

**Warum Identitätsmanagement?** <br>
Einer der Gründe, warum man sich in Unternehmen mit Identitätsmanagement (Identity-Management) beschäftigt, ist die Anforderung, personenbezogene Daten konsistent, ständig verfügbar und verlässlich bereitzuhalten. Dienste wie ein Mail-System oder eine Personalbuchhaltung sind auf diese Daten angewiesen, ohne sie wäre kein individualisierter Betrieb möglich.

*Beispiel* <br> 
Ein Mitarbeiter hat ein Mail-Konto, das nur ihm selbst zugeordnet ist. Hierfür benötigt er eine individuelle Mailadresse, einen sogenannten Account mit dem dazugehörigen Passwort. Diese Daten sind nur für ihn und nicht für die Allgemeinheit bestimmt.

*Gegenbeispiel* <br> 
Eine Firmenpräsentation ist für alle Mitarbeiter einheitlich und bedarf keiner Individualisierung

**Identitätsmanagement von Unternehmen** <br>
Je grösser ein Unternehmen ist, desto mehr müssen Identitäten und Berechtigungen verwaltet werden. Dazu werden sogenannte Identity-Management-Architekturen eingesetzt. Dabei handelt es sich um Softwarekomponenten, die die Identitäten und deren Zugriffsrechte verwalten.

Der Begriff Identity-Management im Software-Umfeld umfasst keinen genau definierten Funktionsumfang. So fokussieren sich beispielsweise einfache Systeme ausschliesslich auf die Synchronisation von personenbezogenen Daten, während umfassendere Architekturen dagegen Workflow-Prozesse einbeziehen, die ein hierarchisches Genehmigungs-Modell von Vorgesetzten beinhalten, um Datenänderungen umzusetzen.

Eine Identity-Management-Architektur sollte über ein Provisionierungsmodul verfügen, das es erlaubt, den Benutzern automatisch aufgrund ihrer jeweiligen Rolle (und auch Aufgaben) in der Organisation individuelle Berechtigungen zu erteilen. Hier stellt sich aber bereits die Frage, wie weit Identity-Management über die ausschliessliche Verwaltung personenbezogener Daten hinweg Applikations-Funktionalitäten integrieren soll (z.B. ist die "Quota" auf einem Mailserver kein personenbezogenes Datum, sondern eine Applikations-Information).

Identity-Management in einem Unternehmen hat vielfach Schnittstellen zum sogenannten Access-Management, das beispielsweise für Portale die Zugriffsrechte verwaltet, Single Sign-on (SSO) ermöglicht oder Security Policies verwaltet. Für die Kombination von Identity-Management und Access Management wurde in der IT daher mittlerweile der Begriff "Identity and Access Management" (IAM oder IdAM) geprägt.


![](../images/Reflexion_36x36.png "Reflexion") 05 - Reflexion
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Eine [Firewall](http://de.wikipedia.org/wiki/Firewall) (von englisch firewall ‚Brandwand‘ oder ‚Brandmauer‘) ist ein Sicherungssystem, das ein Rechnernetz oder einen einzelnen Computer vor unerwünschten Netzwerkzugriffen schützt und ist weiter gefasst auch ein Teilaspekt eines Sicherheitskonzepts.

Der [Reverse Proxy](http://de.wikipedia.org/wiki/Reverse_Proxy) ist ein Proxy, der Ressourcen für einen Client von einem oder mehreren Servern holt. Die Adressumsetzung wird in der entgegengesetzten Richtung vorgenommen, wodurch die wahre Adresse des Zielsystems dem Client verborgen bleibt. Während ein typischer Proxy dafür verwendet werden kann, mehreren Clients eines internen (privaten – in sich geschlossenen) Netzes den Zugriff auf ein externes Netz zu gewähren, funktioniert ein Reverse Proxy genau andersherum.

Die OpenSSH-Suite ist fester Bestandteil quasi aller Linux-Distributionen.

Diese drei wichtigen Eigenschaften führten zum Erfolg von ssh :
* Authentifizierung der Gegenstelle, kein Ansprechen falscher Ziele
* Verschlüsselung der Datenübertragung, kein Mithören durch Unbefugte
* Datenintegrität, keine Manipulation der übertragenen Daten

Wem die Authentifizierung über Passwörter trotz der Verschlüsselung zu unsicher ist, der benutzt das Public-Key-Verfahren. Hierbei wird asymmetrische Verschlüsselung genutzt, um den Benutzer zu authentifizieren. 

![](../images/Magnifier_36x36.png "Quellenverzeichnis") 08 - Quellenverzeichnis
====== 

> [⇧ **Nach oben**](#inhaltsverzeichnis)

![](../images/Samples_36x36.png "Vagrant") 09 - Beispiele
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

* [user - Anlegen von User](../vagrant/user/)
* [ssh - Anlegen von SSH Key's](../vagrant/ssh/)
* [ldap - Mit LDAP Server](../vagrant/ldap/)
* [rest - REST Beispiel mit cgi-bin Script](../vagrant/rest/)
* [tests - Tests ob Installation der Services erfolgreich war](../vagrant/tests/)
* [fwrp - Firewall und Reverse Proxy](../vagrant/fwrp/)
* [iotsrv - 3 VM's mit Apache, MySQL, cron](../vagrant/iotsrv/)
