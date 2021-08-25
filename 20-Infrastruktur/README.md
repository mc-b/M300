M300 - 20 Infrastruktur-Automatisierung
=======================================

Diese Wikiseite zeigt die theoretischen Inhalte beim Einrichten einer Dynamischen Infrastruktur-Plattform (Private Cloud) auf Basis von konsistenten und wiederholbaren Definitionen.

#### Lernziele

Sie können eine Dynamischen Infrastruktur-Plattform (Private Cloud) einrichten, auf der Virtuelle Maschinen auf Basis von konsistenten und wiederholten Definitionen automatisiert erstellt werden können.

#### Voraussetzungen

* [10 Toolumgebung](../10-Toolumgebung/)

#### Inhaltsverzeichnis

* 01 - [Cloud Computing](#-01---cloud-computing)
* 02 - [Infrastructure as Code](#-02---infrastructure-as-code)
* 03 - [Vagrant](#-03---vagrant)
* 04 - [Packer (optional)](#-04---packer)
* 05 - [AWS Cloud (optional)](#-05---aws-cloud)
* 06 - [Reflexion](#-06---reflexion)
* 07 - [Fragen](Fragen.md)
* 08 - [Quellenverzeichnis](#-08---quellenverzeichnis)
* 09 - [Beispiele (für LB2)](#-09---beispiele-für-lb2)
* 10 - [LB 2 hands-on](LB2.md)
* 11 - [Mögliche Serverdienste für die Automatisierung](https://wiki.ubuntuusers.de/Serverdienste/)

___

![](../images/Cloud_Computing_36x36.png "Cloud Computing") 01 - Cloud Computing
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

[![](https://img.youtube.com/vi/36zducUX16w/0.jpg)](https://www.youtube.com/watch?v=36zducUX16w)

Cloud Computing Services Models - IaaS PaaS SaaS Explained

---

Unter **Cloud Computing** (Rechnerwolke) versteht man die Ausführung von Programmen, die nicht auf dem lokalen Rechner installiert sind, sondern auf einem anderen Rechner, der aus der Ferne (remote) aufgerufen wird.

Technischer formuliert umschreibt das Cloud Computing den Ansatz, IT-Infrastrukturen (z.B. Rechenkapazität, Datenspeicher, Datensicherheit, Netzkapazitäten oder auch fertige Software) über ein Netz zur Verfügung zu stellen, ohne dass diese auf dem lokalen Rechner installiert sein müssen.

Angebot und Nutzung dieser Dienstleistungen erfolgen dabei ausschliesslich über technische Schnittstellen und Protokolle sowie über Browser. Die Spannweite der im Rahmen des Cloud Computings angebotenen Dienstleistungen umfasst das gesamte Spektrum der Informationstechnik und beinhaltet unter anderem Infrastruktur, Plattformen und Software (IaaS, PaaS und SaaS).


### Arten von Cloud Computing
***

**Infrastruktur – Infrastructure as a Service (IaaS)** <br>
Die Infrastruktur (auch "Cloud Foundation") stellt die unterste Schicht im Cloud Computing dar. Der Benutzer greift hier auf bestehende Dienste innerhalb des Systems zu, verwaltet seine Recheninstanzen (virtuelle Maschinen) allerdings weitestgehend selbst. 

**Plattform – Platform as a Service (PaaS)** <br>
Der Entwickler erstellt die Anwendung und lädt diese in die Cloud. Diese kümmert sich dann selbst um die Aufteilung auf die eigentlichen Verarbeitungseinheiten. Im Unterschied zu IaaS hat der Benutzer hier keinen direkten Zugriff auf die Recheninstanzen. Er betreibt auch keine virtuellen Server.

**Anwendung – Software as a Service (SaaS** <br>
Die Anwendungssicht stellt die abstrakteste Sicht auf Cloud-Dienste dar. Hierbei bringt der Benutzer seine Applikation weder in die Cloud ein, noch muss er sich um Skalierbarkeit oder Datenhaltung kümmern. Er nutzt eine bestehende Applikation, die ihm die Cloud nach aussen hin anbietet.

Mit dem Advent von Docker (Containierisierung) hat sich zwischen IaaS und PaaS eine neue Ebene geschoben: 

**CaaS (Container as a Service)**<br>
Diese Ebene ist dafür zuständig, containerisierten Workload auf den Ressourcen auszuführen, die eine IaaS-Cloud zur Verfügung stellt. Die Technologien dieser Ebene wie Docker, Kubernetes oder Mesos sind allesamt quelloffen verfügbar. Somit kann man sich seine private Cloud ohne Gefahr eines Vendor Lock-ins aufbauen.


### Dynamic Infrastructure Platforms
***

[![](https://img.youtube.com/vi/KXkBZCe699A/0.jpg)](https://www.youtube.com/watch?v=KXkBZCe699A)

Microsoft How does Microsoft Azure work

---

Eine dynamische Infrastruktur-Plattform (Dynamic Infrastructure Platform) ist ein **System**, das Rechen-Ressourcen  virtualisiert und bereitstellt, insbesondere CPU (**compute**), Speicher (**storage**) und Netzwerke (**networks**). 
Die Ressourcen werden programmgesteuert zugewiesen und verwaltet. Die Bereitstellung erfolgt mit virtuellen Maschinen (VM).

Beispiele sind:
*  Public Cloud
    *  *AWS, Azure, Digital Ocean, Google, exoscale*
*  Private Cloud 
    *  *CloudStack, OpenStack, VMware vCloud*
*  Lokale Virtualisierung 
    *  *Oracle VirtualBox, Hyper-V, VMware Player*
*  Hyperkonvergente Systeme 
    *  *Rechner die die oben beschriebenen Eigenschaften in einer Hardware vereinen*

**Anforderungen**
Damit Infrastructure as Code (IaC) auf dynamischen Infrastruktur-Plattformen genutzt werden kann, müssen sie die folgenden Anforderungen erfüllen:
* **Programmierbar**
    * Ein Userinterface ist zwar angenehm und viele Cloud Anbieter haben ein solches, aber für IaC muss die Plattform via Programmierschnittstelle (API) ansprechbar sein.
* **On-demand**
    * Ressourcen (Server, Speicher, Netzwerke) schnell erstellen und vernichtet.
* **Self-Service**
    * Ressourcen anpassen und auf eigene Bedürfnisse zuschneiden.
* **Portabel**
    * Anbieter von Ressourcen (z.B. AWS, Azure) müssen austauschbar sein.
* Sicherheit, Zertifizierungen (z.B. ISO 27001), etc.



![](../images/Software-Konfiguration_36x36.png "Infrastructure as Code") 02 - Infrastructure as Code
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

**Früher** <br>
In der "Eisenzeit" der IT, waren die IT-Systeme physikalisch an Hardware gebunden. Die Bereitstellung und Aufrechterhaltung der Infrastruktur war manuelle Arbeit. Dabei wurde viel Arbeitszeit investiert, die Systeme bereitzustellen und am Laufen zu halten. Änderungen waren hingegen teuer aufwendig.

**Heute** <br>
Im heutigen "Cloud-Zeitalter" der IT, sind Systeme von der physikalischen Hardware entkoppelt, sie sind Virtualisiert.
Bereitstellung und Wartung können an Software-Systeme delegiert werden und befreien die Menschen von Routinearbeiten.
Änderungen können in Minuten, wenn nicht sogar in Sekunden vorgenommen werden. Das Management kann diese Geschwindigkeit, für einen schnelleren Marktzugang ausnutzen.


### Definition
***
Infrastructure as Code (IaC) ist ein **Paradigma** (grundsätzliche Denkweise) zur Infrastruktur-Automation basierend auf Best Practices der Softwareentwicklung.

Im Vordergrund von IaC stehen konsistente und wiederholbare Definitionen für die Bereitstellung von Systemen und deren Konfiguration. Die Definitionen werden in Dateien zusammengefasst, gründlich Überprüft und automatisch ausgerollt.

Dabei kommen, von der Softwareentwicklung bekannte, Best Practices zum Einsatz:
* Versionsverwaltung - Version Control Systems (VCS)
* Testgetriebene Entwicklung - Testdriven Development (TDD)
* Kontinuierliche Integration - Continuous Integration (CI)
* Kontinuierliche Verteilung - Continuous Delivery (CD)


### Ziele
***
Ziele von **Infrastructure as a Code** (IaC) sind:
* IT-Infrastruktur wird unterstützt und ermöglicht Veränderung, anstatt Hindernis oder Einschränkung zu sein.
* Änderungen am System sind Routine, ohne Drama oder Stress für Benutzer oder IT-Personal.
* IT-Mitarbeiter verbringen ihre Zeit für wertvolle Dinge, die ihre Fähigkeiten fördern und nicht für sich wiederholende Aufgaben.
* Fachanwender erstellen und verwalten ihre IT-Ressourcen, die sie benötigen, ohne IT-Mitarbeiter
* Teams sind in der Lage, einfach und schnell, ein abgestürztes System wiederherzustellen.
* Verbesserungen sind kontinuierlich und keine teuren und riskanten "Big Bang" Projekte.
* Lösungen für Probleme sind durch Implementierung, Tests, und Messen institutionalisiert, statt diese in Sitzungen und Dokumente zu erörtern.


### Tools
***
Folgende Arten von Tools werden für IaC benötigt:
* **Infrastructure Definition Tools**
    * Zur Bereitstellung und Konfiguration einer Sammlung von Ressourcen (z.B. OpenStack, TerraForm, CloudFormation)
* **Server Configuration Tools**
    * Zur Bereitstellung und Konfiguration von Servern bzw. VMs (z.B. Vagrant, Packer, Docker)
* **Package Management Tools**
    * Zur Bereitstellung und Verteilung von vorkonfigurierter Software, vergleichbar mit einem APP-Store. Bei Linux: APT, YUM, bei Windows: WiX, Plattformneutral: SBT native packager
* **Scripting Tools**
    * Kommandozeileninterpreter, kurz CLI (Command-Line Interpreter / Command-Line Shell), zur Schrittweisen Abarbeitung von Befehlen. Bei Linux, Mac und Windows 10: Bash, bei reinem Windows: PowerShell.
* **Versionsverwaltung & Hubs**
    * Zur Versionskontrolle der Definitionsdateien und als Ablage vorbereiteter Images. (z.B. GitHub, Vagrant Boxes, Docker Hub, Windows VM)


![](../images/Vagrant_36x36.png "Vagrant") 03 - Vagrant
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

[![](https://img.youtube.com/vi/X82DXsAeVDQ/0.jpg)](https://www.youtube.com/watch?v=X82DXsAeVDQ)

Vagrant Tutorial Deutsch

---

Vagrant ist eine Ruby-Anwendung (open-source) zum Erstellen und Verwalten von virtuellen Maschinen (VMs).

Die Ruby-Anwendung dient als Wrapper (engl. Verpackung, Umschlag) zwischen Virtualisierungssoftware wie VirtualBox, VMware und Hyper-V und Software-Konfiguration-Management-Anwendungen bzw. Systemkonfigurationswerkzeugen wie Chef, Saltstack und Puppet.

**Wichtig:** Die Virtuellen Maschinen entsprechen lauffähigen Servern.


### Funktionsweise & Konzepte
***

**CLI** <br>
Vagrant wird über die Kommandozeile (CLI) bedient.

Die wichtigsten Befehle sind:

| Befehl                    | Beschreibung                                                      |
| ------------------------- | ----------------------------------------------------------------- | 
| `vagrant init`            | Initialisiert im aktuellen Verzeichnis eine Vagrant-Umgebung und erstellt, falls nicht vorhanden, ein Vagrantfile |
| `vagrant up`              |  Erzeugt und Konfiguriert eine neue Virtuelle Maschine, basierend auf dem Vagrantfile |
| `vagrant ssh`             | Baut eine SSH-Verbindung zur gewünschten VM auf                   |
| `vagrant status`          | Zeigt den aktuellen Status der VM an                              |
| `vagrant port`            | Zeigt die Weitergeleiteten Ports der VM an                        |
| `vagrant halt`            | Stoppt die laufende Virtuelle Maschine                            |
| `vagrant destroy`         | Stoppt die Virtuelle Maschine und zerstört sie.                   |

Weitere Befehle unter: https://www.vagrantup.com/docs/cli/

**Boxen** <br>
Boxen sind bei Vagrant vorkonfigurierte VMs (Vorlagen). Diese sollen den Prozess der Softwareverteilung und der Entwicklung beschleunigen. Jede Box, die von dem Nutzer benutzt wurde, wird auf dem Computer gespeichert und muss so nicht wieder aus dem Internet geladen werden.

Boxen können explizit durch den Befehl `vagrant box add [box-name]` oder `vagrant box add [box-url]` heruntergeladen und durch `vagrant box remove [box-name]` entfernt werden. Ein "box-name" ist dabei durch Konvention wie folgt aufgebaut: *Entwickler/Box* (z.B. ubuntu/xenial64).

Die [Vagrant Boxen-Plattform](https://app.vagrantup.com/boxes/search) dient dabei als Austauschstelle für die Suche nach Boxen und das Publizieren von eigenen Boxen. 

**Konfiguration** <br>
Die gesamte Konfiguration erfolgt im Vagrantfile, das im entsprechenden Verzeichnis liegt. Die Syntax ist dabei an die Programmiersprache Ruby) angelehnt:
```Ruby
    Vagrant.configure("2") do |config|
        config.vm.define :apache do |web|
            web.vm.box = "bento/ubuntu-16.04"
            web.vm.provision :shell, path: "config_web.sh"
            web.vm.hostname = "srv-web"
            web.vm.network :forwarded_port, guest: 80, host: 4567
            web.vm.network "public_network", bridge: "en0: WLAN (AirPort)"
    end
```

**Provisioning** <br>
Provisioning bedeutet bei Vagrant, Anweisung an ein anderes Programm zu geben. In den meisten Fällen an eine Shell, wie Bash. Die nachfolgenden Zeilen installieren den Web Server Apache.
```Ruby
    config.vm.provision :shell, inline: <<-SHELL 
        sudo apt-get update
        sudo apt-get -y install apache2
     SHELL
```

**Provider** <br>
Die Angabe des Providers im Vagrantfile definiert, welche Dynamic Infrastructure Platform zum Einsatz kommt (z.B. VirtualBox).
```Ruby
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "512"  
    end
```


### Workflow
***

**Box hinzufügen** <br>
Hinzufügen einer Box zur lokalen Registry:
```Shell
      vagrant box add [box-name]
```
In der lokalen Registry vorhandene Boxen anzeigen:
```Shell
      vagrant box list
```

**VM erstellen** <br>
Vagrantfile Erzeugen und Provisionierung starten:
```Shell
      mkdir myserver
      cd myserver
      vagrant init ubuntu/xenial64
      vagrant up
```
Aktueller Status der VM anzeigen:
```Shell
      vagrant status
```

**VM updaten** <br>
Nach Änderungen im Vagrantfile kann ein Server wie folgt aktualisiert werden:
```Shell
      vagrant provision
```
oder
```Shell
      vagrant destroy -f
      vagrant up
```

**VM löschen** <br>
Die VM kann wie folgt gelöscht werden:
```Shell
      7vagrant destroy -f
```


### Synced Folders (Gemeinsame Ordner)
***
Synchronisierte Ordner ermöglichen es der VM auf Verzeichnisse des Host-Systems zuzugreifen.

Z.B. das HTML-Verzeichnis des Apache-Webservers mit dem Host-Verzeichnis synchronisieren (wo das Vagrantfile liegt):
```Ruby
    Vagrant.configure(2) do |config|
        config.vm.synced_folder ".", "/var/www/html"  
    end
```

**Wichtig:** Standardmässig wird das aktuelle Vagrantfile-Verzeichnis in der VM unter /vagrant gemountet.

Weiter geht es mit den [Beispielen](#-09---beispiele)

![](../images/Packer_36x36.png "Packer") 04 - Packer
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Packer ist ein Tool zur Erstellung von Images bzw. Boxen für eine Vielzahl von Dynamic Infrastructure Platforms mittels einer Konfigurationsdatei.

**Wichtig:** Images bzw. Boxen sind Vorlagen aus denen Virtuelle Maschinen (VMs) entstehen.

### Funktionsweise
***

Packer wird über die Kommandozeile (CLI) bedient.

Der wichtigste Befehle ist `packer build` um ein Image zu erstellen.

Die Konfiguration erfolgt im JSON Format. Hier ein Beispiel:
```JSON
    {
      "provisioners": [
        {
          "type": "shell",
          "execute_command": "echo 'vagrant'|sudo -S sh '{{.Path}}'",
          "override": {
            "virtualbox-iso": {
              "scripts": [
                "scripts/server/base.sh",
              ]
            }
          }
        }
      ],
      "builders": [
        {
          "type": "virtualbox-iso",
      "boot_command": [
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu-preseed.cfg<wait>",
      ],
        }
      ],
      "post-processors": [
        {
          "type": "vagrant",
          "override": {
            "virtualbox": {
              "output": "ubuntu-server-amd64-virtualbox.box"
            }
          }
        }
      ]      
    }
```

**Provisioning** <br>
Auch bei Packer steht Provisioning für Anweisungen an ein anderes Programm (z.B. eine Shell wie Bash).

**Builder** <br>
Die Builder erstellen ein Image für eine bestimmte dynamische Infrastruktur-Plattform (wie z.B. VirtualBox).

**Post-processors** <br>
Sind Bestandteile von Packer, die das Ergebnis eines Builders oder eines anderen Post-Prozessor übernehmen, um damit ein neues Artefakt zu erstellen. 


### Installation
***
1. Packer herunterladen von: https://www.packer.io/
    * Auf Button `DOWNLOAD ...` klicken
    * Windows 64 oder macOS 64-Bit anwählen
    * Warten, bis Datei heruntergeladen wurde
2. Heruntergeladene Datei `packer_....zip` entpacken
3. Terminal (*Bash*) öffnen & Ordner erstellen:
```Shell
    $ sudo mkdir ~/packer
    $ cd ~/packer 

    $ pwd                               #Gibt den Pfad des Ordners aus
    
    /Users[Dein-Benutzername]/packer
```
4. Entpackte Datei `packer` in das erstelltes Verzeichnis kopieren
```Shell
    $ cp packer ~/packer
```
5. Pfad in der Path-Variable hinterlegen (damit das System das Command kennt):
```Shell
    $ export PATH="$PATH:/Users[Dein-Benutzername]/packer"
```

> #### Änderung und anzeigen der Umgebungsvariablen
>
> Umgebungsvariablen können folgendermassen gesetzt und den anderen Prozessen innerhalb des Betriebssystems bekannt gemacht werden:
>
> Setzen der Variable: <Variablenname>=<Variableninhalt>
> Bekanntmachen der Variable: export <Variablenname>
> Löschen der Variable: unset <Variablenname>
> Abfrage der Variable: env
>
> Weitere Informationen zu Umgebungsvariablen:   
> https://de.wikipedia.org/wiki/Umgebungsvariable#%C3%84nderung_der_Umgebungsvariablen
>

6. Funktion von Packer testen:
```Shell
    $ packer

    Usage: packer [--version] [--help] <command> [<args>]

    Available commands are:
        build       build image(s) from template
        fix         fixes templates from old versions of packer
        inspect     see components of a template
        validate    check that a template is valid
        version     Prints the Packer version
```
7. Terminal (*Bash*) wieder schliessen & mit dieser Dokumentation fortfahren ...
   
### Image erstellen
***

Im nachfolgenden Abschnitt soll in Oracle VirtualBox ein Ubuntu Linux Image erstellt werden.

Was wir dazu benötigen ist eine Packer Konfiguration in JSON-Format und eine ISO-Datei mit einem Ubuntu Image.

Die Packer Konfigurationsdatei kann mit einem normalen Texteditor erzeugt werden und die ISO-Datei finden wir im Downloadbereich von ubuntu.com.

**Post-processors** <br>
Grob zusammengefasst holt Packer die ISO-Datei vom Internet erstellt einen leere VM mit angehängter ISO-Datei und versucht ohne Interaktion vom User ein Ubuntu Linux System zu installieren.

Damit Ubuntu Linux ohne User-Interaktion installiert werden kann braucht es noch eine zusätzliche PreSeed Konfigurationsdatei. Diese gibt dem Installer Anweisungen wie er standardmässig Verfahren soll.

```JSON
    "builders": [
        {
        "type": "virtualbox-iso",
    "boot_command": [
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu-preseed.cfg<wait>",
    ],
```

Ein Beispiel:
```Shell
    debconf debconf/frontend select Noninteractive
    choose-mirror-bin mirror/http/proxy string
    d-i base-installer/kernel/override-image string linux-server
    # Default user
    d-i passwd/user-fullname string vagrant
    d-i passwd/username string vagrant
    d-i passwd/user-password password vagrant
    d-i passwd/user-password-again password vagrant
    d-i passwd/username string vagrant

    # Minimum packages (see postinstall.sh)
    d-i pkgsel/include string openssh-server
    d-i pkgsel/install-language-support boolean false
    d-i pkgsel/update-policy select none
    d-i pkgsel/upgrade select none
```

**Provisioning** <br>
Nach der Installation von Ubuntu Linux werden die Anweisungen in der provisioners Sektion ausgeführt. Hier eine Reihe von vorbereiteten Shell Scripts:
```JSON
    "provisioners": [
        {
        "type": "shell",
        "execute_command": "echo 'vagrant'|sudo -S sh '{{.Path}}'",
        "override": {
            "virtualbox-iso": {
            "scripts": [
                "scripts/server/base.sh",
```

**Post-processors** <br>
Nach Installation und Feintuning wird die Sektion `post-processor` abgearbeitet und ein aufbereitetes Images für den gewünschten Provider, hier Oracle VirtualBox erzeugt:
```JSON
    "post-processors": [
        {
        "type": "vagrant",
        "override": {
            "virtualbox": {
            "output": "ubuntu-server-amd64-virtualbox.box"
            }
        }
    }
```


### Sharing
***
Sobald eine Vagrant-Box gebaut wurde, ist die nächste Herausforderung diese Box mit anderen teilen.

Bei der Freigabe von Vagrant-Boxen gibt es ein paar Dinge zu berücksichtigen:
* Für wen ist die Box erstellt worden? 
    * Für die Öffentlichkeit den Vertrieb, speziell für ein Entwicklungs-Team?
* Wie gross ist die Box? 
    * Die meisten öffentlichen Basis Boxen sind eher klein. Boxen für Entwicklungs-Teams können eine Vielzahl von Tools enthalten und recht gross wird (z.B. IoTKit ist Box 15 GB gross).
* Beinhaltet die Box sensitive Daten wie z.B. Private Keys?

Anstelle der Möglichkeit eine Box auf einem (lokalen) HTTP-Server zu speichern, gibt es auch die Möglichkeit diese beim Entwickler von Vagrant unter https://vagrantcloud.com/ zu speichern.

**HTTP Server Variante** <br>
Nachdem die Box mittels Packer erstellt wurde, wird sie z.B. via SCP (Secure Copy) auf einen HTTP-Server (z.B. lokaler Apache-Webserver) kopiert.

Von dort kann sie dann mittels folgenden Einträgen im Vagrantfile angesprochen werden:
```Ruby
    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
        config.vm.box = "ubuntu-server-amd64-virtualbox.box"
        config.vm.box_url = "http://localhost:8080/ubuntu-server-amd64-virtualbox.box"
    end
```

**Vagrant Boxes Dienst** <br>
Hier ist das Vorgehen wie folgt:
1. Account auf https://vagrantcloud.com/ erstellen
2. `New Box` anwählen und Daten wie Name, Beschreibung etc. erfassen
3. Nach Drücken von `Create Box` kann in einem zweiten Schritt die Release-Informationen angegeben werden
4. Anschliessend mittels `Create Provider` die Zielplattform (z.B. VirtualBox) definieren.
5. Nachdem die Box eingerichtet und hochgeladen wurde, kann sie mittels `unreleased Link` Releast werden.

Nach dem Releasen der Box kann diese in beliebigen Vagrantfile(s) verwendet werden. Hier ein Beispiel:
```Ruby
    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
        config.vm.box = "[yourname]/ubuntu-server-amd64-virtualbox.box"
    end
```

### Alternative Boxen
***

**Vorgefertigte VMs bzw. Vagrant Boxen** <br>
Microsoft stellt zu Testzwecken ihrer verschiedenen Browser (z.B. MS Edge) Versionen vorgefertigter Boxen mit Windows zur Verfügung.

Diese sind via https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/ downloadbar.

**Mittels VM Installation** <br>
Für alle anderen Betriebssysteme ist die jeweilige ISO-Datei herunterzuladen, eine neue VM zu erstellen und als CD-ROM Laufwerk die ISO-Datei einzubinden. Anschliessend kann das entsprechende Betriebssystem normal installiert werden.

Bei der Installation sind folgende Punkte zu berücksichtigen:
* Der **Standard User** muss `vagrant` sein
* Es muss zwingend ein SSH-Server installiert werden

Diese Punkte können in Form von zwei Shell-Scripts (base.sh & vagrant.sh) abgedeckt werden, die in der erstellten VM auszuführen sind:

*base.sh*
```Shell
    #!/bin/bash

    set -o errexit

    apt-get update
    apt-get -y upgrade
    apt-get -y install linux-headers-$(uname -r)

    sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
    sed -i -e 's/%sudo  ALL=(ALL:ALL) ALL/%sudo  ALL=NOPASSWD:ALL/g' /etc/sudoers

    echo "UseDNS no" >> /etc/ssh/sshd_config
```

*vagrant.sh*
```Shell
    #!/bin/bash

    set -o errexit

    # Set up Vagrant.

    date > /etc/vagrant_box_build_time

    # Create the user vagrant with password vagrant
    useradd -G sudo -p $(perl -e'print crypt("vagrant", "vagrant")') -m -s /bin/bash -N vagrant || true

    # Install vagrant keys
    mkdir -pm 700 /home/vagrant/.ssh || true
    curl -Lo /home/vagrant/.ssh/authorized_keys \
    'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
    chmod 0600 /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh

    # Install NFS client
    #apt-get -y install nfs-common
```

Zum Schluss muss die VM nur noch in eine Vagrant-Box umgewandelt werden:
```Shell
    $ vagrant package --base my-virtual-machine
```

Um die Box lokal zu verwenden, wird der Befehl `vagrant box` verwendet:
```Shell
    $ vagrant box add package.box --name localhost/my-virtual-machine
```



![](../images/AWS_36x36.png "AWS Cloud") 05 - AWS Cloud
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Grundlagen
***

**Root Account** <br>
Bezeichnet den Inhaber des AWS-Benutzerkontos. Für den Root sind alle Funktionen in der Cloud freigeschaltet, weshalb mit diesem Benutzer nicht direkt gearbeitet werden soll.

**Regionen** <br>
AWS hat unabhängige Rechenzentren in unterschiedlichen Regionen der Welt, z.B. Irland, Frankfurt, Virginia

**IAM User** <br>
Identity-Management (IAM) ist ein Verwaltungssystem, welches dem Root erlaubt, eigenständige User anzulegen und mit unterschiedlichen Rechten (Permissions & Policies) auszustatten. 

**Network and Security** <br>
Bei AWS gibt es eine Funktion in der EC2-Konsole, welche es erlaubt Security Groups, Key Pairs etc. zu verwalten.

*Security Groups* legen fest welche Ports nach aussen offen sind und können für mehrere VMs gleichzeitig eingerichtet werden.

*Key Pairs* sind Private & Public Keys. Wobei der Public Key bei Amazon verbleibt und der Private Key vom User lokal abgelegt wird um damit auf die VMs in der Cloud zugreifen zu können. 

**AWS Images** <br>
Es gibt vorbereitete VM-Images von AWS, welche einfach über die EC2-Konsole instanziert werden können.


### Vagrant & AWS
***

**Vorbereitungen** <br>
1. Zuerst ist das AWS Vagrant Plugin zu installieren:
```Shell
    $ vagrant plugin install vagrant-aws
```
2. Anschliessend ein Dummy-Image downloaden:
```Shell
    $ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```

Das Dummy-Image wird als Stellvertreter für das effektive Image in der Amazon Cloud gebraucht.

**AWS einrichten** <br>
1. Als erstes ist unter https://aws.amazon.com/de/ ein Root Account einzurichten
    * Dazu braucht es eine gültige Kreditkarte und eine direkte Telefonnummer! 
2. IAM:
    * Nun folgt das Einrichten des Vagrant-Users mit den Rechten, eine EC2 Instanz (AWS-Image) zu instanzieren
    * Dazu ist auf `Identity and Access Management` zu wechseln
    * Auf `Create New Users` zu klicken:
        * **Enter User Names:** vagrant-user
        * **Haken setzen bei:** [X] Generate an access for each user
    * Zurück auf `User` und dem vagrant-user die `EC2FullAccess Policy` erteilen
3. Network and Security:
    * In der EC2 Konsole (wechseln mittels Quadrat links oben, EC2 Anwahl) eine neue Security Group einrichten und unter `Inbound` mindestens die Ports 22 und 80 für `Anywhere` freigeben
    * Wechseln auf `Key Pair` und ein neues Key Paar anlegen. Der Private Key ist **sicher** lokal abzulegen!

**AWS Images** <br>
Nun kann das gewünschte AWS Image unter `Images - AMIs` gesucht werden, um anschliessend die AWI ID (z.B. ami-26c43149) zu notieren.

Einfacher geht es auch mit `Instance - Launch Instance`.

**Konfiguration** <br>
Für die Konfiguration von Vagrant müssen folgende zwei Dateien in einem neuen Verzeichnis angelegt werden. Zusätzlich ist der Private Key (Key Pair) in dieses Verzeichnis zu kopieren.

Die Einträge access_key, secret_key, ec2_keypair und security_group müssen entsprechend angepasst werden.

config.rb
```Ruby
    $aws_options = {}
    # Access und Secret Key vom User vagrant-user
    $aws_options[:access_key] = ""
    $aws_options[:secret_key] = ""
    # Der Name des erstellten Key Pairs
    $aws_options[:ec2_keypair] = "aws-frankfurt-linux.pem"
    # Region Frankfurt 
    $aws_options[:region] = "eu-central-1"
    # Ubuntu 14.04 Images 
    $aws_options[:ami_id] = "ami-26c43149"
    $aws_options[:instance_type] = "t2.micro"
    # Der Name der erstellten Security Group
    $aws_options[:security_group] = "IoTKit Server"
```

Vagrant File
```Ruby
    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    # Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

    VAGRANTFILE_API_VERSION = "2"
    CONFIG = "#{File.dirname(__FILE__)}/config.rb"
    if File.exist?(CONFIG)
    require CONFIG
    end
    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define "web" do |web|
        web.vm.box = "dummy"
        web.vm.provider "aws" do |aws, override|
        override.ssh.username = "ubuntu"
        override.ssh.private_key_path = "#{File.dirname(__FILE__)}/aws-frankfurt-linux.pem"
        aws.access_key_id = $aws_options[:access_key]
        aws.secret_access_key = $aws_options[:secret_key]
        aws.keypair_name = $aws_options[:ec2_keypair]
        aws.region = $aws_options[:region]
        aws.ami = $aws_options[:ami_id]
        aws.instance_type = $aws_options[:instance_type]
        aws.security_groups = $aws_options[:security_group]
        aws.tags = {
            'Name' => 'Vagrant Web Server',
            }
        end
    end
        config.vm.provision "shell", inline: <<-SHELL 
        sudo apt-get update
        sudo apt-get -y install apache2
        SHELL
    end
```

**Image erstellen** <br>
Nachdem die Dateien config.rb und Vagrantfile erstellt wurden kann im erstellten Verzeichnis mittels folgendem Befehl die VM in der Cloud erzeugt werden:
```Shell
    $ vagrant up web --provider=aws
```

![](../images/Reflexion_36x36.png) 06 - Reflexion
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

Unter **[Cloud Computing](https://de.wikipedia.org/wiki/Cloud_Computing)** (deutsch Rechnerwolke) versteht man die Ausführung von Programmen, die nicht auf dem lokalen Rechner installiert sind, sondern auf einem anderen Rechner, der aus der Ferne aufgerufen wird (bspw. über das Internet).

Eine **dynamische Infrastruktur-Plattform** ist ein System, das Rechen-Ressourcen bereitstellt (Virtualisiert),
insbesondere Server (compute), Speicher (storage) und Netzwerke (networks), und diese
Programmgesteuert zuweist und verwaltet, sogenannte **Virtuelle Maschinen** (VM).

Damit "Infrastructure as Code" auf "Dynamic Infrastructure Platforms" genutzt werden können, müssen sie die folgenden Anforderungen erfüllen:

- **Programmierbar** - Ein Userinterface ist zwar angenehm und viele Cloud Anbieter haben eines, aber für "Infrastructure as Code"
muss die Plattform via Programmierschnittstelle ([API](https://de.wikipedia.org/wiki/Programmierschnittstelle)) ansprechbar sein.
- **On-demand** - Ressourcen (Server, Speicher, Netzwerke) schnell erstellen und vernichtet.
- **Self-Service** - Ressourcen anpassen und auf eigene Bedürfnisse zuschneiden.
- **Portabel** - Anbieter von Ressourcen müssen austauschbar sein.
- Sicherheit, Zertifizierungen (z.B. [ISO 27001](https://de.wikipedia.org/wiki/ISO/IEC_27001)), ...


![](../images/Magnifier_36x36.png "Quellenverzeichnis") 08 - Quellenverzeichnis
====== 

> [⇧ **Nach oben**](#inhaltsverzeichnis)

![](../images/Samples_36x36.png "Vagrant") 09 - Beispiele (für LB2)
======

> [⇧ **Nach oben**](#inhaltsverzeichnis)

1.  Terminal (*Bash*) öffnen
2.  In das entsprechende Verzeichnis z.B. `cd M300/vagrant/web` wechseln. `README.md` studieren, z.B. mittels `less README.md`.

* [web - Einfacher Webserver](../vagrant/web/)
* [db - MySQL mit UserInterface](../vagrant/db/)
* [script - Shellscript erstellt mehrere Web Server VM's](../vagrant/script/)
* [mmdb - Multi Machine, Erstellung von mehreren VM's mittels Vagrantfile](../vagrant/mmdb/)
* [lam - Linux, Apache, MySQL, REST Umgebung](../vagrant/lam/)
* [iot - Umfangreicheres Beispiel mit Desktop Umgebung](../vagrant/iot/)
* [cloud-init - Vagrant mit Cloud-init](../vagrant/cloud-init/)
* [MAAS Umgebung in einer VM](../vagrant/maas/)

