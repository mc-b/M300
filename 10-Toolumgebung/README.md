M300 - 10 Toolumgebung
===================

Diese Wikiseite behandelt die Installation von GitHub, VirtualBox, Vagrant und Visual Studio Code.

#### Lernziele

Die nachstehende Dokumentation zeigt alle Schritte auf, die es zur Einrichtung einer vollständig funktionsfähigen Toolumgebung benötigt werden.

#### Voraussetzungen

* PC/Notebook mit min. 8 GB freiem RAM, ca. 20 GB freiem HD-Speicher und einer Ethernet-Netzwerkkarte.
* Einfache [Linux und Apache Web Server](../80-Ergaenzungen/) Kenntnisse sind von Vorteil.
* Ein schneller Netzwerk- (Kabel!) und Internet-Anschluss

#### Allgemeine Hinweise

Die meisten Arbeiten erfolgen auf der Kommandozeile, hier als **Terminal** (*Bash*) bezeichnet.

In der Kommandozeile bzw. im Terminal läuft die "Bash" Shell. Das ist nur die Shell von Linux und noch kein vollständiges Linux System. 

Diese Umgebung wird verwendet, weil benötige Programme wie `git`, `ssh-keygen` in der Powershell nicht zur Verfügung stehen. 

Um sich im Filesystem zurechtzufinden, sind folgende Befehle nützlich:
* `cd /Verzeichnis` wechselt in Verzeichnis z.B. `cd /Users`, alternativ kann die Windows Schreibweise in " verwendet werden, z.B. `cd "C:\Users"`
* Alternativ kann im Windows Explorer jederzeit ein Terminal mittels rechter Maustaste und `Git Bash Here` geöffnet werden.
* `cd ~` Wechsel ins eigene Home-Verzeichnis. Dort werden SSH-Keys etc. abgelegt.
* `cd -` wird auf das zuletzt verwendete Verzeichnis gewechselt.
* Die Laufwerke von Windows stehen als `/c`, `/d/` zur Verfügung, Bsp. `cd /c/Users` und `cd "C:\Users"` sind indentisch
* `ls -l` zeigt die Dateien im aktuellen Verzeichnis an
* `pwd` zeigt den aktuellen Pfad an.
* Die Windows Befehle stehen auch im Terminal zur Verfügung, z.B. `notepad README.md` 

#### Inhaltsverzeichnis

* 01 - [GitHub Account](#-01---github-account)
* 02 - [Git Client](#--02---git-client)
* 03 - [VirtualBox](#--03---virtualbox)
* 04 - [Vagrant](#--04---vagrant)
* 05 - [Visual Studio Code](#-05---visual-studio-code) / [Alternative Markdown Editoren](#alternative-editoren)
* 06 - [Quellenverzeichnis](#-06---quellenverzeichnis)

___

![](../images/GitHub_36x36.png "GitHub") 01 - GitHub Account 
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Als erster Schritt muss ein GitHub-Account eingerichtet werden. Dieser dient uns später als "Cloud-Speicher" unserer Dokumentation und weiteren Dateien.

Folgende Arbeiten müssen gemacht werden:

### Account erstellen
***
1. Auf www.github.com ein Benutzerkonto erstellen (Angabe von Username, E-Mail und Passwort)
2. E-Mail zur Verifizierung des Kontos bestätigen und anschliessend auf GitHub anmelden


### Repository erstellen
***
1. Anmelden unter www.github.com 
2. Innerhalb der Willkommens-Seite auf <strong>Start a project</strong> klicken
3. Unter <strong>Repository name</strong> einen Name definieren (z.B. M300-Services)
4. Optional: kurze Beschreibung eingeben
5. Radio-Button bei <strong>Public</strong> belassen
6. Haken bei <strong>Initialize this repository with a README</strong> setzen
7. Auf <strong>Create repository</strong> klicken
   
### SSH-Key erstellen (lokal)
***

**ACHTUNG**: Auf Windows muss zuerst [Git/Bash](#--02---git-client) installiert werden. Anschliessend können die Befehle in der Git/Bash ausgeführt werden. Dabei handelt es sich nur um die Shell von Linux, die auf Windows ausgeführt wird. Alternativ können Sie für die meisten Befehle auch die *PowerShell* verwenden.

1.  Terminal (*Bash*) öffnen
2.  Folgenden Befehl mit der Account-E-Mail von GitHub einfügen:
    ```Shell
      $  ssh-keygen -t rsa -b 4096 -C "beispiel@beispiel.com"
    ```
3. Neuer SSH-Key wird erstellt:
    ```Shell
      Generating public/private rsa key pair.
    ```
4. Bei der Abfrage, unter welchem Namen der Schlüssel gespeichert werden soll, die Enter-Taste drücken (für Standard):
    ```Shell
      Enter a file in which to save the key (~/.ssh/id_rsa): [Press enter]
    ```
5. Nun kann ein Passwort für den Key festgelegt werden. Ich empfehle dieses zu setzen und anschliessend dem SSH-Agent zu hinterlegen, sodass keine erneute Eingabe (z.B. beim Pushen) notwendig ist:
    ```Shell
      Enter passphrase (empty for no passphrase): [Passwort]
      Enter same passphrase again: [Passwort wiederholen]
    ```

### SSH-Key dem SSH-Agent hinzufügen 
***

**Windows und Linux**

Datei %HOME%/.ssh/id_rsa.pub oder $HOME/.ssh/id_rsa.pub in Zwischenablage kopieren.

**macOS**

1.  Terminal (*Bash*) öffnen
2.  SSH-Agent starten:
    ```Shell
      $ eval "$(ssh-agent -s)"
      Agent pid 931
    ```
3.  Ab Version macOS High Sierra 10.12.2 muss das `~/.ssh/config` File angepasst werden, damit SSH-Keys automatisch dem SSH-Agent hinzugefügt werden:
    ```Shell
      $ sudo nano ~/.ssh/config
      
      Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_rsa
    ```
4.  Nun muss der Schlüssel dem Agent nur noch hinzugefügt werden:
    ```Shell
      $ ssh-add -k ~/.ssh/id_rsa
    ```
5.  Der SSH-Key muss nun nur noch kopiert und anschliessend dem GitHub-Account hinzugefügt werden (siehe "SSH-Key hinzufügen"):
    ```Shell
      $ cat ~/.ssh/id_rsa.pub
      # Kopiert den Angezeiten Inhalt der id_rsa.pub Datei in die Zwischenablage
    ``` 

### SSH-Key hinzufügen
***
1.  Anmelden unter www.github.com
2.  Auf Benutzerkonto klicken (oben rechts) und den Punkt <strong>Settings</strong> aufrufen
3.  Unter den Menübereichen auf der linken Seite zum Abschnitt <strong>SSH und GPG keys</strong> wechseln
4.  Auf <strong>New SSH key</strong> klicken
5.  Im Formular unter <strong>Title</strong> eine Bezeichnung vergeben (z.B. MB SSH-Key)
6.  Den zuvor kopierten Key mit <i>CTRL + V</i> einfügen und auf <strong>Add SSH key</strong> klicken
7.  Der Schlüssel (SSH-Key) sollte nun in der übergeordneten Liste auftauchen


> Weiter Infos zu SSH-Keys in Zusammenhang mit GitHub und dem SSH-Agent findet man unter:

> **GitHub-Help:**  https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

> **Wikipedia:**    https://en.wikipedia.org/wiki/Ssh-agent


![](../images/Git_36x36.png "Git Client")  02 - Git Client
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Damit die Arbeiten lokal auf dem eigenen PC erfolgen können, muss der sogenannte "Git Client", auf Windows "Git/Bash" installiert werden. Dieser ermöglicht uns,
Cloud-Repositories zu klonen, zu pullen (herunterladen) oder ein lokales Repository zu pushen (hochladen).

Hierzu müssen folgende Schritte durchgeführt werden: 

### Client installieren
***
1. Für die Client-Installation muss der Installer unter [dieser Webseite](https://git-scm.com/downloads) heruntergeladen werden 
2. Die Installation erfolgt GUI-basiert, jedoch Standard (ohne speziellen Anpassungen). Daher wird an dieser Stelle auf eine Erklärung verzichtet.
3. Sobald der Vorgang abgeschlossen wurde, kann mit der Konfiguration fortgefahren werden.


### Client konfigurieren
***
1. Terminal (*Bash*) öffnen
2. Git konfigurieren mit Informationen des GitHub-Accounts:
    ```Shell
      $ git config --global user.name "<username>"
      $ git config --global user.email "<e-mail>"
    ``` 
3. Konfiguration abgeschlossen


### Repository klonen
***
1. Zu Testzwecken soll ein Repository geklont werden. Dazu sind folgende Befehle notwendig:
2. Terminal (*Bash*) öffnen
3. Repository klonen: 
    ```Shell
      $ git clone https://github.com/mc-b/M300
    ``` 
4. In das M300-Verzeichnis wechseln:
    ```Shell
      $ cd M300
    ``` 
5. Repository aktualisieren und Status anzeigen:
    ```Shell
      $ git pull

      Already up to date.

      $ git status

      Your branch is up to date with 'origin/master'.
    ``` 
6. Die Statusmeldung soll dabei mitteilen, dass das lokale Repository mit dem Originalen übereinstimmt.

### Repository herunterladen & aktualisieren (clone/pull)
***
1. Terminal (*Bash*) öffnen
2. Ordner für Repository im gewünschten Verzeichnis erstellen:
    ```Shell
      $ cd Wohin/auch/immer
      $ mkdir MeinLokalesRepository
    ``` 
3. Repository mit SSH klonen (siehe Webseite des Repositorys unter "Clone or download"):
    ```Shell
      $ git clone git@github.com:<Ihr Name>/my_M300.git

      Cloning into 'my_M300'...
    ``` 
4. Repository aktualisieren und Status anzeigen:
    ```Shell
      $ git pull

      Already up to date.
    ```

### Repository hochladen (Push)
***
1.  Terminal (*Bash*) öffnen (nachdem Teile bzw. Dateien des lokalen Repositorys geändert wurden)
2.  In das entsprechende Verzeichnis des Repository gehen: 
    ```Shell
      $ cd Pfad/zu/meinem/Repository  
    ```  
3.  Dateien dem Upload hinzufügen:
    ```Shell
      $ git add -A .
    ``` 
4.  Den Upload commiten:
    ```Shell
      $ git commit -m "Mein Kommentar"
    ``` 
5.  Schliesslich den Upload pushen:
    ```Shell
      $ git push
    ```
6.  Nun sollte der Master-Branch des Repositorys ebenfalls aktualisiert sein

### Übersicht "How to Push"
***

Dieser Abschnitt zeigt die Handhabung von Git-Befehlen auf. Mit den nachfolgenden Kommandos pusht man das (geänderte) Repository zu seinem GitHub-Repository.

Wichtig: Die Befehle müssen innerhalb des lokalen Repositorys ausgeführt werden!

```Shell 
$  cd Pfad/zu/meinem/Repository    # Zum lokalen GitHub-Repository wechseln

$  git status                      # Geänderte Datei(en) werden rot aufgelistet
$  git add -A                      # Fügt alle Dateien zum "Upload" hinzu
$  git status                      # Der Status ist nun grün > Dateien sind Upload-bereit (Optional) 
$  git commit -m "Mein Kommentar"  # Upload wird "commited" > Kommentar zu Dokumentationszwecken ist dafür notwendig
$  git status                      # Dateien werden nun als "zum Pushen bereit" angezeigt
$  git push                        #Upload bzw. Push wird durchgeführt
```


![](../images/VirtualBox_36x36.png "VirtualBox")  03 - VirtualBox
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Nun widmen wir uns der Virtualisierung von Computersystemen. Für den Betrieb von solchen Maschinen bzw. Computern stehen zahlreiche Virtualisierungsanwendungen zur Verfügung. Eine davon ist VirtualBox. In diesem Kapitel richten wir eine einfache VM (Virtuelle Maschine) mit VirtualBox ein. Also ganz traditionell und wie sich im späteren Verlauf zeigt, auch eine sehr aufwendige Arbeit.

Folgende Arbeiten müssen gemacht werden:

### Software herunterladen & installieren
***
1. Zuerst muss die VirtualBox-Anwendung installiert werden. Der Installer lässt sich [hier](https://www.virtualbox.org/) herunterladen.
2. Die Installation erfolgt GUI-basiert, jedoch Standard (ohne spezielle Anpassungen). Daher wird an dieser Stelle auf eine Erklärung verzichtet.
3. Sobald der Vorgang abgeschlossen wurde, kann mit dem Herunterladen der ISO-Datei und der VM-Erstellung fortgefahren werden.

### ISO-Datei herunterladen
***
Für das weitere Vorgehen wird eine System-Abbild-Datei benötigt. Dazu laden wir in unserem Fall das Image von Ubuntu Desktop 16.04.05 herunter. Wie das genau funktioniert, wird nachfolgend beschrieben:

1. Das Systemabbild (ISO-Image) über [diesen Link](https://www.ubuntu.com/#download) herunterladen. Wenn Download zu lange geht USB Stick vom Lehrer erfragen.
2. Datei im gewünschten Verzeichnis ablegen (damit das Image wiederverwendet werden kann)
3. Allen Anweisung in Abschnitt "VM erstellen" folgen

### VM erstellen
***
1. VirtualBox starten
2. Links oben, innerhalb der Anwendung, auf `Neu` klicken
3. Im neuen Fenster folgende Informationen eintragen:
   *  Name:           `M300_Ubuntu_XX.04_Desktop`
   *  Typ:            `Linux`
   *  Version:        `Ubuntu (64-bit)`
   *  Speichergrösse: `2048 MB`
   *  Platte:         `[X] Festplatte erzeugen`
4. Auf `Erzeugen` klicken
5. Weiteres Fenster öffnet sich, folgende Informationen eintragen:
   *  Dateipfad:                       standard
   *  Dateigrösse:                     `10.00 GB`
   *  Dateityp der Festplatte:         `VMDK (Virtual Maschine Disk)`
   *  Storage on physical hard disk:   `dynamisch alloziert`
6. Ebenfalls auf `Erzeugen` klicken, dann im Hauptmenü die VM anwählen (blau markiert) und den Punkt `Ändern` aufrufen
7. Im Abschnitt `Massenspeicher` den SATA-Controller anwählen und auf das CD+Symbol klicken
8. Unter `Medium auswählen` das zuvor heruntergeladene Systemabbild (ISO-Datei) anwählen
9. Alle Änderungen speichern und die VM starten
10. Den Installationsanweisungen der OS-Installation folgen und anschliessend zu Abschnitt "VM einrichten" gehen

Falls Linux nicht bootet: In den *Settings* der virtuellen Maschine unter *Speicher* überprüfen, ob die virt. HD am IDE-Controller angeschlossen ist. 

### VM einrichten
***
Die virtuelle Maschine (VM) sollte nun soweit betriebsbereit sein, sprich der Zugriff auf den Home-Desktop ist möglich. 

1. Ubuntu-VM starten
2. Anmelden und Terminal (*Bash*) öffnen
3. Paketliste neu einlesen und Pakete aktualisieren:
   ```Shell 
   $  sudo apt-get update   #Paketlisten des Paketmanagement-Systems "APT" neu einlesen
   
   $  sudo apt-get upgrade   #Installierte Pakete wenn möglich auf verbesserte Versionen aktualisieren

   $  sudo reboot           #System-Neustart durchführen
   ```
4. Software Controlcenter "Synaptic" installieren:
   ```Shell 
   $  sudo apt-get install synaptic
   ```
5. Nach erfolgreicher Installation in der Suche nach "Synaptic Package Manager" suchen und diesen starten
6. Innerhalb des Managers nach "apache" (Webserver-Programm) suchen und dieses (inkl. aller Abhängigkeiten) installieren
7. System-Neustart durchführen:
   ```Shell 
   $  sudo reboot
   ```
8. Gängiger Web-Browser (z.B. Firefox) starten und prüfen, ob der Standard-Content des Webservers unter "http://127.0.0.01:80" (localhost) erreichbar ist
9. Browser-Fenster schliessen und VM wieder herunterfahren/stoppen
10. Mit dem Kapitel 4 (Vagrant) fortfahren

![](../images/Vagrant_36x36.png "Vagrant")  04 - Vagrant
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

[![](https://img.youtube.com/vi/mPBWWu7sZU4/0.jpg)](https://www.youtube.com/watch?v=mPBWWu7sZU4)

So richten Sie Virtual Box und Vagrant unter Windows ein

---

Kapitel 3 (VirtualBox) sollte uns zeigen, dass das Bereitstellen virtueller Systeme in der konventionellen Art lange dauert und umständlich sein kann.
Abhilfe bietet hier Vagrant. Vagrant ist eine freie Ruby-Anwendung zur Erstellung und Verwaltung virtueller Maschinen und ermöglicht einfache Softwareverteilung.

Nachfolgend sind einzelne Schritte zur Einrichtung von Vagrant dokumentiert:

### Software herunterladen & installieren
***
1. Die Anwendung kann auf der [offiziellen Webseite](https://www.vagrantup.com/ "vagrantup.com") heruntergeladen werden.
2. Die Installation erfolgt, wie alle anderen Anwendungen, GUI-basiert, jedoch Standard (ohne spezielle Anpassungen). Daher wird an dieser Stelle ebenfalls auf eine Erklärung verzichtet.
3. Sobald der Vorgang abgeschlossen wurde, kann mit dem Erstellen einer VM fortgefahren werden. 

### Virtuelle Maschine erstellen
***
1. Terminal (*Bash*) öffnen
2. In gewünschtem Verzeichnis einen neuen Ordner für die VM anlegen:
    ```Shell
      $ cd Wohin/auch/immer
      $ mkdir MeineVagrantVM
      $ cd MeineVagrantVM
    ``` 
3. Vagrantfile erzeugen, VM erstellen und entsprechend starten:
    ```Shell
      $ vagrant init ubuntu/xenial64        #Vagrantfile erzeugen
      $ vagrant up --provider virtualbox    #Virtuelle Maschine erstellen & starten
    ``` 
4. Die VM ist nun in Betrieb (erscheint auch in der Übersicht innerhalb von VirtualBox) und kann via SSH-Zugriff bedient werden:
    ```Shell
      $ cd Pfad/zu/meiner/Vagrant-VM      #Zum Verzeichnis der VM wechseln
      $ vagrant ssh                       #SSH-Verbindung zur VM aufbauen

      #Anschliessend können ganz normale Bash-Befehle abgesetzt werden:

      $ ls -l /bin  #Bin-Verzeichnis anzeigen
      $ df -h       #Freier Festplattenspeicher
      $ free -m     #Freier Arbeitsspeicher
    ``` 
5. VM über VirtualBox-GUI ausschalten

Schlussfolgerung: Eine VM lässt sich mit Vagrant eindeutig schneller und unkomplizierter erstellen!


### Virtuelle Maschine erstellen (mit Vagrant-Box auf Netzwerkshare)
***
1. Terminal (*Bash*) öffnen
2. In gewünschtem Verzeichnis einen neuen Ordner für die VM anlegen:
    ```Shell
      $ cd Wohin/auch/immer
      $ mkdir MeineVagrantVM
      $ cd MeineVagrantVM
    ``` 
3. Vagrantfile erzeugen, VM erstellen und entsprechend starten:
    ```Shell
      $ vagrant init ubuntu/xenial64                                                      #Vagrantfile erzeugen
      $ vagrant up --provider virtualbox                                                  #Virtuelle Maschine erstellen & starten
    ``` 
4. Die VM ist nun in Betrieb (erscheint auch in der Übersicht innerhalb von VirtualBox) und kann via SSH-Zugriff bedient werden:
    ```Shell
      $ cd Pfad/zu/meiner/Vagrant-VM      #Zum Verzeichnis der VM wechseln
      $ vagrant ssh                       #SSH-Verbindung zur VM aufbauen

      #Anschliessend können ganz normale Bash-Befehle abgesetzt werden:

      $ ls -l /bin  #Bin-Verzeichnis anzeigen
      $ df -h       #Freier Festplattenspeicher
      $ free -m     #Freier Arbeitsspeicher
    ``` 
5. VM über VirtualBox-GUI ausschalten

Schlussfolgerung: Keine erheblichen Unterschiede zum ersten Teil (ohne Share) und daher auch nicht wirklich kompliziert.

### Apache Webserver automatisiert aufsetzen
***
Um den Automatisierungsgrad von Vagrant im Rahmen dieser Dokumentation etwas besser hervorzuheben, richten wir eine VM, dass sie direkt mit einem vorinstallierten Apache-Webserver startet. Dazu können wir im Vagrantfile den Code etwas leicht abändern und direkt auf Bash-Ebene mit einfachen Befehlen arbeiten. 

Nachfolgend wird die VM mit einem bereits abgeänderten File bzw. VM aus dem M300-Repository erstellt:

1. Terminal (*Bash*) öffnen
2. In das M300-Verzeichnis (/M300/vagrant/web) wechseln:
    ```Shell
      $ cd Pfad/zum-M300-Verzeichnis/vagrant/web
    ``` 
3. VM erstellen und starten:
    ```Shell
      $ vagrant up
    ``` 
4. Webbrowser in der VM öffnen und prüfen, ob der Standard-Content des Webservers unter "http://127.0.0.01:8080" (localhost) erreichbar ist
5. Im Ordner `/web` die Hauptseite `index.html` editieren bzw. durch eine andere ersetzen (z.B. HTML5up-Themplate) und das Resultat überprüfen
6. Abschliessend kann die VM wieder gelöscht werden:
    ```Shell
      $ vagrant destroy -f
    ```
7. Vagrant ist nun komplett einsatzfähig!


![](../images/VisualStudioCode_36x36.png "Visual Studio Code") 05 - Visual Studio Code
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Bis hierhin haben wir soweit alles aufgesetzt und installiert. Nun möchten wir für effizienteres Arbeiten eine "Entwicklungsumgebung" aufbauen, die es uns ermöglicht, alle lokalen Repositories an einem Ort zu verwalten und die dazugehörigen Dateien zu bearbeiten. Die Lösung hierzu ist: Visual Studio Code 
Dieser freie Quelltext-Editor von Microsoft, ermöglicht uns, unsere Workflows besser zu gestalten und damit die Arbeit um einiges leichter zu machen.

Für die Einrichtung muss man sich nach den nachfolgenden Anweisungen orientieren:

### Software herunterladen & installieren
***
1. Unter [dieser Webseite](https://code.visualstudio.com/ "visualstudio.com") lässt sich der Installer (Version 1.26.1) herunterladen.
2. Auf "Download for Mac" klicken und warten, bis das Fenster zum Herunterladen erscheint. Anschliessend den Download des Installers starten
3. Die Installation erfolgt auch hier GUI-basiert. Wiederum aber Standard (ohne spezielle Anpassungen), sodass an dieser Stelle auf eine Erklärung ebenfalls verzichtet wird.
4. Sobald der Vorgang abgeschlossen wurde, kann mit dem Herunterladen der ISO-Datei und der VM-Erstellung fortgefahren werden.


### Extensions installieren
***

Wir fügen dem Editor drei wichtige Extensions hinzu:

* Markdown All in One (von Yu Zhang)
* Vagrant Extension (von Marco Stanzi)
* vscode-pdf Extension (von tomiko1207)

Dazu müssen folgende Anweisungen befolgt werden: 

1. Visual Studio Code öffnen
2. Die Tastenkombination `CTRL` + `SHIFT` + `X` drücken und in der Suchleiste die erwähnten Extensions suchen
3. Auf `Install` klicken und anschliessend auf `Reload`, um die Extension in den Arbeitsbereich zu laden.
4. Nun können die Extensions angewendet werden. Für Markdown ist [diese Liste](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet/"github.com") sehr hilfreich.


### Einstellungen anpassen
***
Damit keine Dateien der virtuellen Maschinen dem Cloud-Repository hinzugefügt werden (da Dateien zu gross), müssen diese in den Einstellungen "exkludiert" werden:

1. Visual Studio Code öffnen
2. Unter `File` > `Preferences` > `Settings` (`Ctrl` + `,`) auf `Open setting.json` klicken
3. Zu diesem Abschnitt gehen:
     ```
      // Configure glob patterns for excluding files and folders. For example, the files 
      explorer decides which files and folders to show or hide based on this setting. 
      Read more about glob patterns here. (...)
    ``` 
4. Nachstehenden Code einfügen:
     ```
      // Konfiguriert die Globmuster zum Ausschließen von Dateien und Ordnern.
      "files.exclude": {
        "**/.git": true,
        "**/.svn": true,
        "**/.hg": true,
        "**/.vagrant": true,
        "**/.DS_Store": true
      },
    ```
5. Änderungen speichern und die Einstellungen schliessen
   
Nun sollten keine Dateien mit den Endungen .git / .svn / .hg / .vagrant / .DS_store hochgeladen werden. Wie man die Änderungen innerhalb von Visual Studio Code richtig pusht, wird im nachfolgenden Abschnitt erklärt. 

### Repository hinzufügen & pushen
***
1. Visual Studio Code öffnen
2. Änderungen an entsprechenden Dateien des lokalen Repositorys vornehmen
3. In der linken Leiste das Symbol mit einer "1" aufrufen
4. Unter dem Abschnitt **Changes** die betroffenen Files bezüglich ihres Changes "stagen" (**Stage Changes**)
5. Nachricht hinterlegen (**Message**) und Haken (**Commit**) setzen
6. Bei den 3 Punkten (...) die Funktion **Push** aufrufen
7. Warten, bis Dateien vollständig gepusht wurden

***
### Alternative Editoren

#### Atom IO

https://atom.io/  
Atom ist ein Open-Source-Texteditor, der als integrierte Entwicklungsumgebung für eine grosse Auswahl an Programmiersprachen verwendet werden kann, der dank des durchgehenden Supports der Git-Community viele Möglichkeiten eröffnet.

Alle Features eines guten Editors sind enthalten, wie Syntax-Highlighter, automatische Erkennung von Sprachen, automatische Textvervollständigung, die Möglichkeit mehrere Panels zu verwenden und Projekte in verschiedenen Ordnern zu sichern, Support für Snippets und eine leistungsstarke Suche. Der grösste Vorteil ist die Modularität der Umgebung (Features können durch  zusätzliche Pakete hinzugefügt werden). Es inkludiert auch ein Steuersystem für Git, mit dem der Inhalte über die GitHub-Plattform veröffentlicht wird.

Atom ist für mehrere Plattformen (Windows, Linux und Mac) ausgelegt. Die IDE besticht mit ihren Anpassungsoptionen: Beim Schreiben stehen einem mehr als 2.000 Pakete und 600 Themes zur Verfügung. Mit der grossen Menge an Anpassungen und Features ist sie sicherlich eines der besten Entwicklertools am Markt. Sie verbraucht ausserdem nur wenig Speicherplatz auf dem Computer im Vergleich zu ähnlichen Alternativen. 
***

#### StackEdit

StackEdit ist ein Markdown Editor im Browser.

* [https://stackedit.io/](https://stackedit.io/)

#### Typora

Typora bietet Ihnen eine nahtlose Erfahrung als Leser und Autor. Es entfernt das Vorschaufenster, den Modusumschalter, die Syntaxsymbole des Markdown-Quellcodes und alle anderen unnötigen Ablenkungen. Diese werden durch eine echte Live-Vorschau ersetzt, damit Sie sich auf den Inhalt selbst konzentrieren können.

* [Typora](https://typora.io/)


![](../images/Magnifier_36x36.png "Quellenverzeichnis") 06 - Quellenverzeichnis
====== 
***

> [⇧ **Nach oben**](#inhaltsverzeichnis)

  * Formatierung Markdown-Cheatsheet: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

  * Code- und Syntax-Highlighting: https://github.com/github/linguist/blob/master/lib/linguist/languages.yml

  * Das SSH-Key-Problem: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/


___
