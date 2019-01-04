M300 - Toolumgebung (10)
======

Dieses Repository behandelt die Installation von GitHub, VirtualBox, Vagrant und Visual Studio Code.

#### Einleitung

Die nachstehende Dokumentation wurde von Michael Blickenstorfer im Rahmen des Moduls M300 (Plattformübergreifende Dienste in ein Netzwerk integrieren)
erarbeitet und zeigt alle Schritte auf, die es zur Einrichtung einer vollständig funktionsfähigen Toolumgebung benötigt.

#### Revision History

| Datum         | Änderungen                                                                         |  Kürzel  |
| ------------- |:-----------------------------------------------------------------------------------| :------: |
| 29.08.2018    | Erstellung der Datei & erste Änderungen eingeführt                                 |    MBL   |
| 08.09.2018    | Einleitung, Voraussetzungen, Inhaltsverzeichnis & Kapitel 1 erarbeitet             |    MBL   |
| 09.09.2018    | Kapitel 2, 3, 4, 5 und 6 erarbeitet                                                |    MBL   |
| 10.09.2018    | Kapitel 7 erarbeitet und kleinere Ergänzungen an den anderen Kapitel vorgenommen   |    MBL   |
| 10.09.2018    | Bilder bzw. Icons eingefügt                                                        |    MBL   |
| 20.10.2018    | Verknüpfungen angepasst                                                            |    MBL   |
| 30.10.2018    | Kleinere Verbesserungen vorgenommen                                                |    MBL   |
|      ...      | ...                                                                                |    ...   |

#### Voraussetzungen
* [X] macOS High Sierra (Version 10.13.6)
* [X] GitHub Account
* [X] Git-OSX-Installer (Version 2.15.0)
* [X] VirtualBox (Version 5.2.18)
* [X] Vagrant (Version 2.1.4)
* [X] Visual Studio Code (Version 1.26.1)

#### Inhaltsverzeichnis
* 01 - [GitHub Account](https://github.com/TacoNaco47/M300_10_Toolumgebung#-01---github-account)
* 02 - [Git Client](https://github.com/TacoNaco47/M300_10_Toolumgebung#--02---git-client)
* 03 - [VirtualBox](https://github.com/TacoNaco47/M300_10_Toolumgebung#--03---virtualbox)
* 04 - [Vagrant](https://github.com/TacoNaco47/M300_10_Toolumgebung#--04---vagrant))
* 05 - [Visual Studio Code](https://github.com/TacoNaco47/M300_10_Toolumgebung#-05---visual-studio-code)
* 06 - [Fazit / Reflexion](https://github.com/TacoNaco47/M300_10_Toolumgebung#-06---fazit--reflexion)
* 07 - [Quellenverzeichnis](https://github.com/TacoNaco47/M300_10_Toolumgebung#-07---quellenverzeichnis)

___

![](https://raw.githubusercontent.com/TacoNaco47/M300_Toolumgebung/master/images/GitHub_36x36.png "GitHub") 01 - GitHub Account 
======

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

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
3. Unter <strong>Repository name</strong> einen Name definieren (z.B. M300)
4. Optional: kurze Beschreibung eingeben
5. Radio-Button bei <strong>Public</strong> belassen
6. Haken bei <strong>Initialize this repository with a README</strong> setzen
7. Auf <strong>Create repository</strong> klicken
   

### SSH-Key erstellen (lokal)
***
1.  Terminal öffnen
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
1.  Terminal öffnen
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
      $ ssh-add -K ~/.ssh/id_rsa
    ```
5.  Der SSH-Key muss nun nur noch kopiert und anschliessend dem GitHub-Account hinzugefüg werden (siehe "SSH-Key hinzufügen"):
    ```Shell
      $ pbcopy < ~/.ssh/id_rsa.pub
      # Kopiert den Inhalt der id_rsa.pub Datei in die Zwischenablage
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


![](https://raw.githubusercontent.com/TacoNaco47/M300_Toolumgebung/master/images/Git_36x36.png "Git Client")  02 - Git Client
======

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

Damit die Arbeiten lokal auf dem eigenen PC erfolgen können, muss der sogenannte "Git Client" installiert werden. Dieser ermöglicht uns,
Cloud-Repositories zu klonen, zu pullen (herunteraden) oder ein lokales Repository zu pushen (hochladen).

Hierzu müssen folgende Schritte durchgeführt werden: 

### Client installieren
***
1. Für die Client-Installation muss der Installer unter [dieser Webseite](http://sourceforge.net/projects/git-osx-installer/ "sourceforge.net/projects/git-osx-installer") heruntergeladen werden (Version 2.15.0)
2. Die Installation erfolgt GUI-basiert, jedoch standard (ohne speziellen Anpassungen). Daher wird an dieser Stelle auf eine Erklärung verzichtet.
3. Sobald der Vorgang abgeschlossen wurde, kann mit der Konfiguration fortgefahren werden.


### Client konfigurieren
***
1. Terminal öffnen
2. Git konfigurieren mit Informationen des GitHub-Accounts:
    ```Shell
      $ git config --global user.name "<username>"
      $ git config --global user.email "<e-mail>"
    ``` 
3. Konfiguration abgeschlossen


### Repository klonen
***
1. Zu Testzwecken soll ein Repository geklont werden. Dazu sind folgende Befehle notwendig:
2. Terminal öffnen
3. Repository klonen: 
    ```Shell
      $ git clone https://github.com/mc-b/devops
    ``` 
4. In das devops-Verzeichnis wechseln:
    ```Shell
      $ cd devops
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
1. Terminal öffnen
2. Ordner für Repository im gewünschten Verzeichnis erstellen:
    ```Shell
      $ cd Wohin\auch\immer
      $ mkdir MeinLokalesRepository
    ``` 
3. Repository mit SSH klonen (siehe Webseite des Repositorys unter "Clone or download"):
    ```Shell
      $ git clone git@github.com:TacoTaco47/M300.git

      Cloning into 'M300'...
    ``` 
4. Repository aktualisieren und Status anzeigen:
    ```Shell
      $ git pull

      Already up to date.
    ```

### Repository hochladen (Push)
***
1.  Terminal öffnen (nachdem Teile bzw. Dateien des lokalen Repositorys geändert wurden)
2.  In das entsprechende Verzeichnis des Repository gehen: 
    ```Shell
      $ cd Pfad\zu\meinem\Repository  
    ```  
3.  Dateien dem Upload hinzufügen:
    ```Shell
      $ git add -a.
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
$  cd Pfad\zu\meinem\Repository    # Zum lokalen GitHub-Repository wechseln

$  git status                      # Geänderte Datei(en) werden rot aufgelistet
$  git add -a                      # Fügt alle Dateien zum "Upload" hinzu
$  git status                      # Der Status ist nun grün > Dateien sind Upload-bereit (Optional) 
$  git commit -m "Mein Kommentar"  # Upload wird "commited" > Kommentar zu Dokumentationszwecken ist dafür notwendig
$  git status                      # Dateien werden nun als "zum Pushen bereit" angezeigt
$  git push                        #Upload bzw. Push wird durchgeführt
```


![](https://raw.githubusercontent.com/TacoNaco47/M300_Toolumgebung/master/images/VirtualBox_36x36.png "VirtualBox")  03 - VirtualBox
======

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

Nun widmen wir uns der Virtualisierung von Computersystemen. Für den Betrieb von solchen Maschinen bzw. Computern stehen zahlreiche Virtualisierungsanwendungen zur Verfügung. Eine davon ist VirtualBox. In diesem Kapitel richten wir eine einfache VM (Virtuelle Maschine) mit VirtualBox ein. Also ganz traditionell und wie sich im späteren Verlauf zeigt, auch eine sehr aufwendige Arbeit.

Folgende Arbeiten müssen gemacht werden:

### Software herunterladen & installieren
***
1. Zuerst muss die VirtualBox-Anwendung installiert werden. Der Installer lässt sich [hier](https://www.virtualbox.org"virtualbox.org") herunterladen.
2. Auf "Download VirtualBox 5.2" klicken und bei Abschnitt "VirtualBox 5.2.19 platform packages" dem OS X hosts Link folgen (Datei wird heruntergeladen)
3. Die Installation erfolgt GUI-basiert, jedoch standard (ohne speziellen Anpassungen). Daher wird an dieser Stelle auf eine Erklärung verzichtet.
4. Sobald der Vorgang abgeschlossen wurde, kann mit dem Herunterladen der ISO-Datei und der VM-Erstellung fortgefahren werden.

### ISO-Datei herunterladen
***
Für das weitere Vorgehen wird eine System-Abbild-Datei benötigt. Dazu laden wir in unserem Fall das Image von Ubuntu Desktop 16.04.05 herunter. Wie das genau funktioniert, wird nachfolgend beschrieben:

1. Das Systemabbild (ISO-Image) über [diesen Link](http://releases.ubuntu.com/16.04/ubuntu-16.04.5-desktop-amd64.iso.torrent"ubuntu.com") herunterladen
2. Datei im gewünschten Verzeichnis ablegen (damit das Image wiederverwendet werden kann)
3. Allen Anweisung in Abschnitt "VM erstellen" folgen

### VM erstellen
***
1. VirtualBox starten
2. Links oben, innerhalb der Anwendung, auf `Neu` klicken
3. Im neuen Fenster folgende Informationen eintragen:
   *  Name:           `M300_Ubuntu_16.04_Desktop`
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
6. Ebenefalls auf `Erzeugen` klicken, dann im Hauptmenü die VM anwählen (blau markiert) und den Punkt `Ändern` aufrufen
7. Im Abschnitt `Massenspeicher` den SATA-Controller anwählen und auf das CD+Symbol klicken
8. Unter `Medium auswählen` das zuvor heruntergeladene Systemabbild (ISO-Datei) anwählen
9. Alle Änderungen speichern und die VM starten
10. Den Installationsanweisungen der OS-Installation folgen und anschliessend zu Abschnitt "VM einrichten" gehen

### VM einrichten
***
Die virtuelle Maschine (VM) sollte nun soweit betriebsbereit sein, sprich der Zugriff auf den Home-Desktop ist möglich. 

1. Ubuntu-VM starten
2. Anmelden und Terminal öffnen
3. Paketliste neu einlesen und Pakete aktualisieren:
   ```Shell 
   $  sudo apt-get update   #Paketlisten des Paketmanagement-Systems "APT" neu einlesem
   
   $  sudo apt-get update   #Installierte Pakete wenn möglich auf verbesserte Versionen aktualisieren

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

![](https://raw.githubusercontent.com/TacoNaco47/M300_Toolumgebung/master/images/Vagrant_36x36.png "Vagrant")  04 - Vagrant
======

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

Kapitel 3 (VirtualBox) sollte uns zeigen, dass das Bereitstellen virtueller Systeme in der konventionellen Art lange dauert und umständlich sein kann.
Abhilfe bietet hier Vagrant. Vagrant ist eine freie Ruby-Anwendung zur Erstellung und Verwaltung virtueller Maschinen und ermöglicht einfache Softwareverteilung.

Nachfolgend sind einzelne Schritte zur Einrichtung von Vagrant dokumentiert:

### Software herunteladen & installieren
***
1. Die Anwendung in der Version 2.1.4 kann auf der [offiziellen Webseite](https://www.vagrantup.com/ "vagrantup.com") heruntergeladen werden.
2. Die Installation erfolgt, wie alle anderen Anwendungen, GUI-basiert, jedoch standard (ohne speziellen Anpassungen). Daher wird an dieser Stelle ebenfalls auf eine Erklärung verzichtet.
3. Sobald der Vorgang abgeschlossen wurde, kann mit dem Erstellen einer VM fortgefahren werden. 


### Virtuelle Maschine erstellen
***
1. Terminal öffnen
2. In gewünschtem Verzeichnis einen neuen Ordner für die VM anlegen:
    ```Shell
      $ cd Wohin\auch\immer
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
      $ cd Pfad\zu\meiner\Vagrant-VM      #Zum Verzeichnis der VM wechseln
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
1. Terminal öffnen
2. In gewünschtem Verzeichnis einen neuen Ordner für die VM anlegen:
    ```Shell
      $ cd Wohin\auch\immer
      $ mkdir MeineVagrantVM
      $ cd MeineVagrantVM
    ``` 
3. Vagrantfile erzeugen, VM erstellen und entsprechend starten:
    ```Shell
      $ vagrant box add http://[HOST]/vagrant/ubuntu/xenial64.box --name ubuntu/xenial64  #Vagrant-Box vom Netzwerkshare hinzufügen
      $ vagrant init ubuntu/xenial64                                                      #Vagrantfile erzeugen
      $ vagrant up --provider virtualbox                                                  #Virtuelle Maschine erstellen & starten
    ``` 
4. Die VM ist nun in Betrieb (erscheint auch in der Übersicht innerhalb von VirtualBox) und kann via SSH-Zugriff bedient werden:
    ```Shell
      $ cd Pfad\zu\meiner\Vagrant-VM      #Zum Verzeichnis der VM wechseln
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

Nachfolgend wird die VM mit einem bereits abgeänderten File bzw. VM aus dem devops-Repository erstellt:

1. Terminal öffnen
2. In das devops-Verzeichnis (\devops\vagrant\web) wechseln:
    ```Shell
      $ cd Pfad\zum\dvops-Verzeichnis\devops\vagrant\web
    ``` 
3. VM erstellen und starten:
    ```Shell
      $ vagrant up
    ``` 
4. Webbrowser öffnen und prüfen, ob der Standard-Content des Webservers unter "http://127.0.0.01:80" (localhost) erreichbar ist
5. Im Ordner `\web` die Hauptseite `index.html` editieren bzw. durch eine andere ersetzen (z.B. HTML5up-Themplate) und das Resultat überprüfen
6. Abschliessend kann die VM wieder gelöscht werden:
    ```Shell
      $ vagrant destroy -f
    ```
7. Vagrant ist nun komplett einsatzfähig!


![](https://raw.githubusercontent.com/TacoNaco47/M300_10_Toolumgebung/master/images/VisualStudioCode_36x36.png "Visual Studio Code") 05 - Visual Studio Code
======

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

Bis hierhin haben wir soweit alles aufgesetzt und installiert. Nun möchten wir für effizienteres Arbeiten eine "Entwicklungsumgebung" aufbauen, die es uns ermöglicht, alle lokalen Repositories an einem Ort zu verwalten und die dazugehörigen Dateien zu bearbeiten. Die Lösung hierzu ist: Visual Studio Code 
Dieser freie Quelltext-Editor von Microsoft, ermöglicht uns, unsere Workflows besser zu gestalten und damit die Arbeit um einiges leichter zu machen.

Für die Einrichtung muss man sich nach den nachfolgenden Anweisungen orientieren:

### Software herunteladen & installieren
***
1. Unter [dieser Webseite](https://code.visualstudio.com/"visualstudio.com") lässt sich der Installer (Version 1.26.1) herunterladen.
2. Auf "Download for Mac" klicken und warten, bis das Fenster zum Herunterladen erscheint. Anschliesend den Download des Installers starten
3. Die Installation erfolgt auch hier GUI-basiert. Wiederum aber standard (ohne speziellen Anpassungen), sodass an dieser Stelle auf eine Erklärung ebenfalls verzichtet wird .
4. Sobald der Vorgang abgeschlossen wurde, kann mit dem Herunterladen der ISO-Datei und der VM-Erstellung fortgefahren werden.


### Extensions installieren
***

Wir fügen dem Editor drei wichtige Extensions hinzu:

* Markdown All in One (Version 1.6.0 / von Yu Zhang)
* Vagrant Extension (Version 0.5.0 / von Marco Stanzi)
* vscode-pdf Extension (Version 0.3.0 / von tomiko1207)

Dazu müssen folgende Anweisungen befolgt werden: 

1. Visual Studio Code öffnen
2. Die Tastenkombination `CTRL` + `SHIFT` + `X` drücken und in der Sucheleiste die erwähnten Extensions suchen
3. Auf `Install` klicken und anschliessend auf `Reload`, um die Extension in den Arbeitsbereich zu laden.
4. Nun können die Extensions angewendet werden. Für Markdown ist [diese Liste](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet/"github.com") sehr hilfreich.


### Einstellungen anpassen
***
Damit keine Dateien der virtuellen Maschinen dem Cloud-Repository hinzugefügt werden (da Dateien zu gross), müssen diese in den Einstellungen "exkludiert" werden:

1. Visual Studio Code öffnen
2. Unter `Code` > `Preferences` > `Settings` bei den 3 Punkten (...) auf `Open setting.json` klicken
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

![](https://raw.githubusercontent.com/TacoNaco47/M300_10_Toolumgebung/master/images/Reflexion_36x36.png "Fazit / Reflexion") 06 - Fazit / Reflexion
======

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

Mir persönlich hat die Einrichtung der Tool-Umgebung sehr viel Freude bereitet. Besonders das Erarbeiten der Dokumentation fand ich interessant, da ich bis anhin den Funktionsumfang von GitHub in Kombination mit Markdown nicht kannte. Da für mich alles sehr neu war, musste ich mich in einer ersten Phase erst einmal in die einzelnen Bereiche einarbeiten und Schritt für Schritt die Anweisungen befolgen. Grösstenteils hatte ich dabei keine Mühe und ich konnte bereits in geraumer Zeit einen Grossteil der Aufgaben abschliessen. Trotz gelegentlichen unklaren Passagen innerhalb der uns zur Verfügung gestellten [«Doku»](http://iotkit.mc-b.ch/tbz/M300V3/html/10-Installation/ "iotkit.mc-b.ch"), konnte ich diese Hindernisse überwinden und mein bis jetzt erlangtes Fachwissen voll und ganz einsetzen. Das einzig nennenswerte Problem stellte die Erstellung des SSH-Keys und die anschliessende Verwendung innerhalb der Visual Studio Code Applikation dar. Da ich (trotz Anweisungen) meinen SSH-Key mit einem Passwort schützen wollte – denn die Sicherheit geht vor(!), hatte ich anschliessend Probleme, wenn ich Änderungen direkt in der Visual Studio Code Umgebung in das Cloud-Repository pushen wollte. In einem Artikel der GitHub-Hilfeseite wird dies jedoch empfohlen und so wurde mir glücklicherweise aufgezeigt, wie man diese Problematik mit dem Hinzufügen des Keys an den SSH-Agent vollständig umgehen kann. Dadurch konnte ich die Umgebung vollständig einrichten und mein Vorgehen entsprechend dokumentieren.

Für zukünftige Arbeiten werde ich GitHub wohl wieder als unterstützende Hilfe bei der Dokumentation von gemachten Arbeiten verwenden, da der Umfang sehr gross ist und auch der visuelle Aspekt meiner Ansicht nach perfekt ist: ordentlich, modern und sauber!

![](https://raw.githubusercontent.com/TacoNaco47/M300_10_Toolumgebung/master/images/Magnifier_36x36.png "Quellenverzeichnis") 07 - Quellenverzeichnis
====== 

> [⇧ **Nach oben**](https://github.com/TacoNaco47/M300_10_Toolumgebung#m300---toolumgebung-10)

Die obigen Anleitungen habe ich mit mehreren Quellen erarbeitet und dokumentiert. Das nachfolgende Quellverzeichnis soll Aufschluss über die verwendeten Quellen geben und ein Zeichen der Dankbarkeit und Anerkennung sein.

**TBZ Repository Server (Toolumgebung aufsetzen)**
  <br>
  * Diese Dokumentation basiert grundsätzlich auf den Grundlagen nachfolgender Anweisungen, die durch die Schule bereitgestellt wurden: http://iotkit.mc-b.ch/tbz/

**GitHub**
  <br>
  * Für die Formatierung nahm ich das Markdown-Cheatsheet zur Hilfe: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

  * Bei Code- und Syntax-Highlighting half mir folgende Übersicht: https://github.com/github/linguist/blob/master/lib/linguist/languages.yml

  * Das SSH-Key-Problem löste ich mit folgendem Hilfe-Artikel: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/


___