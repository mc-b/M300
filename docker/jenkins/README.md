VM mit Docker und Dockerfile für Jenkins
----------------------------------------

### Beschreibung

Build Umgebung mit [jenkins](https://jenkins.io/).

Docker Container builden:

	cd /vagrant/jenkins
	docker build -t jenkins .

Docker Container starten:

	docker run -d --name jenkins -p 8082:8080 --rm \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v /vagrant:/vagrant \
	   jenkins

Um nachher die Jenkins Oberfläche mittels [http://localhost:8082](http://localhost:8082) aufzurufen.

In der Jenkins Oberfläche erstellt einen neuen Build mit eine Build Schritt "Shell ausführen" und gebt dort folgendes ein:

	sudo docker run --name for ubuntu:14.04 bash -c 'for x in 1 2 3 4 5; do echo $x; sleep 1; done;'
	sudo docker logs for
	sudo docker rm for

Apache Web Server analog anlegen wie oben aber mit folgendem Build Schritt:

	cd /vagrant/apache
	sudo docker build -t apache .
	
Bessere Variante mit `git clone` (Sourcen von GitHub):

	rm -rf M300
	git clone https://github.com/mc-b/M300.git
	cd M300/docker/apache
	sudo docker build -t apache .
