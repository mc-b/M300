Fragen
======

### Container
***

Was ist der Unterschied zwischen Vagrant und Docker?
<details><summary>Antwort</summary>
 	Vagrant ist für IaaS und Docker für PaaS
</p></details>

---

Was welches Tools aus dem Docker Universum ist Vergleichbar mit Vagrant?
<details><summary>Antwort</summary>
 	docker machine
</p></details>

---

Was macht der Docker Provisioner ?
<details><summary>Antwort</summary>  
	 	Installiert Docker in einer VM
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

### Docker Hub
***

---
Was ist der Unterschied zwischen der Verwendung der Docker Registry und `docker save` und `docker load`?
<details><summary>Antwort</summary>
	 	Registry ist in der Cloud und Images sind für alle sichtbar, save und load passiert lokal mit Dateien
</p></details>

---

Was ist der Unterschied zwischen `docker save`/`docker load` und `docker export`/`docker import`?
<details><summary>Antwort</summary>
	 	save/load ist für Images, export/import für Container
</p></details>

---

Was ist bei einer eigenen Registry zu beachten?
<details><summary>Antwort</summary>
	 	Sicherheit, bzw. das mögliche Fehlen davon
</p></details>

---

Warum sollten Versionen `tag` von Images immer angegeben werden?
<details><summary>Antwort</summary>
	 	Ansonsten wird `latest` verwendet und so nicht sicher ist welche Version wirklich verwendet wird.
</p></details>

---