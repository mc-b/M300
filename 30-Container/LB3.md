LB 3 hands-on
=============

### Umgebung funktionsfähig auf eigenem Notebook 
***

Eine Docker Umgebung muss funktionsfähig auf dem eigenen Notebook installiert sein.

Das kann z.B. mittels den [github](https://github.com/mc-b/M300)-Beispielen mit [VirtualBox](https://www.virtualbox.org/) und [Vagrant](https://www.vagrantup.com/) erreicht werden.

	cd M300/docker
	vagrant up
	vagrant ssh
	docker run hello-world
	
Alternative ist eine Native Installation von Docker mittels des Installationsprogrammes von [docker.com](https://www.docker.com/community-edition)
	
### Bestehende Docker Container kombinieren oder Container als Backend, Desktop App als Frontend 
***

Es soll ein Backend, z.B. in Form einer Datenbank, und ein Frontend, z.B. eine Web Applikation, miteinnander kombiniert werden.

Dazu ist zuerst ein geeignetes Frontend, welches eine Datenbank benötigt auf [docker hub](http://hub.docker.com) zu suchen.

Frontend Kandidaten sind z.B.:
* [Ghost](https://hub.docker.com/_/ghost/)
* [Nextcloud](https://hub.docker.com/_/nextcloud/)
* [Redmine](https://hub.docker.com/_/redmine/)

Ein komplettes Beispiel verpackt als Vagrantfile ist [OS Ticket](../services/osticket) oder [ghost](../services/ghost).

**Tip**:

Zuerst eine Testumgebung bauen. Z.B. `Vagrantfile` aus [M300/docker](../docker/Vagrantfile) Verzeichnis mit Installation Docker und pull der benötigten Images.

	  config.vm.provision "docker" do |d|
	   d.pull_images "mysql:5.7"
	   d.pull_images "ghost:1-alpine"
	   d.pull_images "adminer" 
	  end
 
Um dann mittels Kommandozeile die richtigen Docker Befehle auszuprobieren. 

	docker run -d -name <container> -p<ports> <images>
	docker run -d -name <container> --link <containers> -p<ports> <images>
	curl localhost:<ports>
	docker stop
	docker rm <container>

Wenn alles übereinstimmt, diese wieder ins `Vagrantfile` ablegen.

	   # Docker Provisioner
	  config.vm.provision "docker" do |d|
	   d.pull_images "mysql:5.7"
	   d.pull_images "ghost:1-alpine"
	   d.run "ghost_mysql", image: "mysql:5.7", args: "-e MYSQL_ROOT_PASSWORD=admin -e MYSQL_USER=ghost -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=ghost --restart=always"
	   d.run "ghost", image: "ghost:1-alpine", args: "--link ghost_mysql:mysql -e database__client=mysql -e database__connection__host=ghost_mysql -e database__connection__user=ghost -e database__connection__password=secret -e database__connection__database=ghost -p 2368:2368 --restart=always"
	  end

### Eigene Container erstellen
***

Es soll ein eigener Docker Container erstellt werden. Dazu muss zuerst ein Dockerfile und aus diesem ein Docker Image erstellt werden.

Umwandlung `Vagrantfile` nach `Dockerfile`:

**Vagrantfile**:

	Vagrant.configure(2) do |config|
	  config.vm.box = "ubuntu/xenial64"
	  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
	  config.vm.synced_folder ".", "/var/www/html"  
	config.vm.provider "virtualbox" do |vb|
	  vb.memory = "512"  
	end
	config.vm.provision "shell", inline: <<-SHELL
	  sudo apt-get update
	  sudo apt-get -y install apache2 
	SHELL
	end
	
**Dockerfile**:

	FROM ubuntu:14.04
	RUN apt-get update
	RUN apt-get -q -y install apache2 
	# Konfiguration Apache
	ENV APACHE_RUN_USER www-data
	ENV APACHE_RUN_GROUP www-data
	ENV APACHE_LOG_DIR /var/log/apache2
	RUN mkdir -p /var/lock/apache2 /var/run/apache2
	EXPOSE 80
	VOLUME /var/www/html
	CMD /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

* `config.vm.box` -> `FROM` - Grundimage
* `forwarded_port` -> `EXPOSE` - Port Weiterleitung
* `config.vm.synced_folder` -> `VOLUME` - Ablage Daten
* `config.vm.provider` - entfällt weil [PaaS](https://de.wikipedia.org/wiki/Cloud_Computing) statt [IaaS](https://de.wikipedia.org/wiki/Cloud_Computing)
* `config.vm.provision "shell", inline: <<-SHELL` -> `RUN` - Befehle zur Installation der Software 
* `CMD` -> weil in Container ein `systemd` fehlt, ist der Service explizit zu starten. Evtl. sind, wie oben Umgebungsvariablen zu setzen, damit der Service weiss, wo sich seine Dateien etc. befinden.

#### Container sichern und beschränken

Nachdem die Container laufen, sollten die Images auf evtl. Sicherheitslücken überprüft werden. Ebenfall sollte sichergestellt werden, dass die Container nicht unbeschränkt Systemressourcen beanspruchen 

Anhaltspunkte dazu liefert das Kapitel 35 Container-Sicherheit:
- [Container sichern und beschraenken](../35-Sicherheit/)

#### Testen und Health Check

Um Abstürze in laufenden Containern zu erkennen, gibt es u.a. den Eintrag `HEALTHCHECK` in `Dockerfile`.

Weitere Informationen stehen im Kapitel Docker Grundlagen und in der Docker Referenz Dokumentation:
* [Dockerfile](README.md#dockerfile)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/#healthcheck)

