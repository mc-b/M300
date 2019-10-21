Fragen
======

### Container
***

Was ist der Unterschied zwischen Vagrant und Docker?
<details><summary>Antwort</summary>
 	Vagrant ist für IaaS (Virtuelle Maschinen) und Docker für PaaS bzw. CaaS (Container)
</p></details>

---

Was welches Tools aus dem Docker Universum ist Vergleichbar mit Vagrant?
<details><summary>Antwort</summary>
 	docker machine
</p></details>

---

Was macht der Docker Provisioner von Vagrant?
<details><summary>Antwort</summary>  
	 	Installiert Docker in einer VM
</p></details>

---

Welche Linux Kernel Funktionalität verwenden Container?
<details><summary>Antwort</summary>  
        Linux Namespaces, siehe auch [The Missing Introduction To Containerization](https://medium.com/faun/the-missing-introduction-to-containerization-de1fbb73efc5)
</p></details>

---

Welches Architekturmuster verwendet der Entwickler wenn er Container einsetzt?
<details><summary>Antwort</summary>  
        Microservices
</p></details>

---

Welches sind die drei Hauptmerkmale (abgeleitet vom Ur-Unix) von Microservices?
<details><summary>Antwort</summary>  
        Ein Programm soll nur eine Aufgabe erledigen, und das soll es gut machen. Programme sollen zusammenarbeiten können. Nutze eine universelle Schnittstelle. In UNIX sind das Textströme. Bei Microservices das Internet (REST).
</p></details>

---

### Docker
***

Was ist der Unterschied zwischen einem Docker Image und einem Container?
<details><summary>Antwort</summary>
	 	Image = gebuildet und readonly, Container Image + aktuelle Änderungen im Filesystem
</p></details>

---

Was ist der Unterschied zwischen einer Virtuellen Maschine und einem Docker Container?
<details><summary>Antwort</summary>
	 	VM hat Betriebssystem mit am laufen, Docker nur die eigenen Prozesse
</p></details>
	
---

Wie bekomme ich Informationen zu einem laufenden Docker Container?
<details><summary>Antwort</summary>
	 	docker logs, docker inspect
</p></details>

---

Was ist der Unterschied zwischen einer Docker Registry und einem Repository
<details><summary>Antwort</summary>
        In der Docker Registry werden die Container Images gespeichert. Ein Repository speichert pro Container Image verschiedene Versionen von Images.
</p></details>

---

Wie erstelle ich ein Container Image
<details><summary>Antwort</summary>
    docker build 
</p></details>

---

In welcher Datei steht welche Inhalte sich im Container Image befinden?
<details><summary>Antwort</summary>
    Dockerfile 
</p></details>

---

Der erste Prozess im Container bekommt die Nummer?
<details><summary>Antwort</summary>
    1 
</p></details>

---

Welche Teile von Docker sind durch Kubernetes obsolet geworden, bzw. sollten nicht mehr verwendet werden?
<details><summary>Antwort</summary>
    Swarm, Compose, Network, Volumes
</p></details>

---

Welche Aussage ist besser (siehe auch [The Twelve-Factor App](https://12factor.net/))?
* a) Dockerfile sollten möglichst das Builden (CI) und Ausführen von Services beinhalten, so ist alles an einem Ort und der Entwickler kann alles erledigen.
* b) Das Builden und Ausführen von Services ist strikt zu trennen. Damit saubere und nachvollziehbare Services mittels CI/CD Prozess entstehen. 
<details><summary>Antwort</summary>
    b)
</p></details>

---

### Docker Hub
***

Was ist Docker Hub?
<details><summary>Antwort</summary>
        Ein Container Registry, wo Container Image gespeichert werden. Docker Hub wird durch die Firma Docker zur Verfügung gestellt wird.
</p></details>

---

Welches sind die Alternativen?
<details><summary>Antwort</summary>
        Praktisch jeder Cloud Anbieter stellt eine Container Registry zur Verfügung. Auch die Anbieter für die Verwaltung von Build Artefakten (z.B. Sonatype Nexus) stellen Docker Registries zur Verfügung oder haben deren Funktionalität integriert. 
</p></details>

---

Warum sollte eine eigene Docker Registry im Unternehmen verwendet werden?
<details><summary>Antwort</summary>
        Sicherheit, bzw. das mögliche Fehlen davon. Es kann nicht Sichergestellt werden, dass alle Container Images auf Docker Hub sicher sind.
</p></details>

---

Warum sollten Versionen `tag` von Images immer angegeben werden?
<details><summary>Antwort</summary>
	 	Ansonsten wird `latest` verwendet und so nicht sicher welche Version wirklich verwendet wird.
</p></details>

---

Was ist der Unterschied zwischen `docker save`/`docker load` und `docker export`/`docker import`?
<details><summary>Antwort</summary>
        save/load ist für Images, export/import für Container.
        So ist es möglich auch ohne Docker Registry Container Images auszutauschen, z.B. in einer Bank.
</p></details>

---