LB2 hands-on
============

#### Voraussetzungen

* [10 Toolumgebung](../10-Toolumgebung/)
* [Mögliche Serverdienste für die Automatisierung](https://wiki.ubuntuusers.de/Serverdienste/)

### Neue VM zum Testen erstellen 
***

Um einen Service zu automatisieren, ist es von Vorteil, eine VM zum Testen zu erstellen. In dieser können dann die Befehle manuell ausprobiert werden, bevor 
sie in `Vagrantfile` übertragen werden.

Zuerst erzeugen wir ein neues Verzeichnis mit einer `Vagrantfile` mit einem Ubuntu 16.x (ubuntu/xenial64).

	cd myM300/
	mkdir myVM
	cd myVM
	vagrant init ubuntu/xenial64
	vagrant up
	
Zum Testen wechseln wir in die VM
	
	vagrant ssh
	
### Serverdienste auswählen
***	

Anschliessend suchen wir uns die Serverdienste aus, welche wir automatisieren wollen. Dabei hilft diese [Wikiseite](https://wiki.ubuntuusers.de/Serverdienste/) von Ubuntu.

Wir haben uns für [Webanalyzer](https://wiki.ubuntuusers.de/Webalizer/) entschieden, dazu braucht es jedoch auch den [Apache](https://wiki.ubuntuusers.de/Apache_2.4/) Webserver.

Zuerst müssen immer die Paketquellen von Ubuntu aktualisiert werden, dies erfolgt als Superuser (Linux = root, Windows = Administrator)

	sudo apt-get update
	
	
Dann folgt die Installation von [Apache](https://wiki.ubuntuusers.de/Apache_2.4/). Dabei darf das Argument `-y` nicht vergessen werden, ansonsten bleibt der Installationsbefehl stehen und verlangt vom User eine manuelle Eingabe.

	sudo apt-get install -y apache2
	
Das/die Grundpaket(e) sind installiert, nun kümmern wir uns um den eigentlichen Service [Webanalyzer](https://wiki.ubuntuusers.de/Webalizer/)

	sudo apt-get install -y webalizer 
	
Wenn alles läuft, schauen wir uns mit `history` die gemachten Eingaben an und kopieren die relevanten Befehle in die `Vagrantfile`.	

### Feintuning 
***	
	
#### Probleme

* Dateien sind nach dem Zerstören der VM nicht mehr vorhanden
* Port vom Webserver, in der VM, wird nicht weitergeleitet an Host. 
* Es existiert keine index.html unter `/var/www/webalizer/index.html`. Siehe **Hinweis** bei [Verwendung](https://wiki.ubuntuusers.de/Webalizer/#Verwendung)
* Der URL (z.B. via `curl http://localhost/webalizer`) von Webanalyzer kann nicht abgerufen werden

#### Lösungen

**Dateien und Port Weiterleitung** 
* siehe [Web Beispiel](../vagrant/web)

**Um einen Output zu Erzeugen sind mehrere Aktionen nötig:**

Erzeugung von Trafic z.B. mittels `curl http://localhost/` (*PowerShell: Invoke-WebRequest*)
    
    curl http://localhost/ >/dev/null 2>&1
	curl http://localhost/ >/dev/null 2>&1
	curl http://localhost/ >/dev/null 2>&1
	curl http://localhost/ >/dev/null 2>&1
	curl http://localhost/bad >/dev/null 2>&1    
    
Rotieren des Access Logs von Apache, weil Webanalyzer nur Archivdaten auswertet. Siehe **Hinweis** bei [Verwendung](https://wiki.ubuntuusers.de/Webalizer/#Verwendung)

	sudo logrotate -f /etc/logrotate.d/apache2    
    
Korrektur des Output Verzeichnisses in `/etc/webalizer/webalizer.conf` 

	sudo sed -i -e"s:/var/www/webalizer:/var/www/html/webalizer:" /etc/webalizer/webalizer.conf 
	
Manuelle Erzeugung des Webanalyzer Ausgaben

	sudo /etc/cron.daily/webalizer 
	
Das komplette `Vagrantfile` sieht dann so aus:

	Vagrant.configure(2) do |config|
	  config.vm.box = "ubuntu/xenial64"
	  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
	  config.vm.synced_folder ".", "/var/www/html"  
	config.vm.provider "virtualbox" do |vb|
	  vb.memory = "512"  
	end
	config.vm.provision "shell", inline: <<-SHELL
	  # Packages vom lokalen Server holen
	  # sudo sed -i -e"1i deb {{config.server}}/apt-mirror/mirror/archive.ubuntu.com/ubuntu xenial main restricted" /etc/apt/sources.list 
	  # Debug ON!!!
	  set -o xtrace  
	  sudo apt-get update
	  sudo apt-get -y install apache2 webalizer 
	  sudo /etc/cron.daily/webalizer
	  # Testdaten erzeugen
	  curl http://localhost/ >/dev/null 2>&1
	  curl http://localhost/ >/dev/null 2>&1
	  curl http://localhost/ >/dev/null 2>&1
	  curl http://localhost/ >/dev/null 2>&1
	  curl http://localhost/bad >/dev/null 2>&1
	  # Patch falsches Output Verzeichnis von webalizer 
	  sudo sed -i -e"s:/var/www/webalizer:/var/www/html/webalizer:" /etc/webalizer/webalizer.conf 
	  sudo mkdir -p /var/www/html/webalizer 
	  # Logfiles von Apache rotieren und neue Analyse
	  sudo logrotate -f /etc/logrotate.d/apache2
	  sudo /etc/cron.daily/webalizer  
	SHELL
	end

### Sicherheit
***

Die VW sollte zusätzlich mit einer Firewall abgesichert werden.

Ist die VM Teil mehrerer VMs bzw. Webservers, können diese mittels eines Reverse Proxies zu einem zusammengefasst werden (braucht nur ein SSL-Zertifikat).

Ein Beispiel dazu findet man unter [fwrp](../vagrant/fwrp) und die Beschreibung unter [25 Infrastruktur-Sicherheit](../25-Sicherheit/).