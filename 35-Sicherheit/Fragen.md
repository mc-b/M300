Fragen
======

### Protokollieren & Überwachen
***

Warum sollten Container überwacht werden?
<details><summary>Antwort</summary>  
	 Um Fehler oder grosse Ressourcenbelastungen frühzeitig zu erkennen und einzugreifen	
</p></details>

---

Was ist das syslog und wo ist es zu finden?
<details><summary>Antwort</summary>  
	 	Das Systemweite Log eines Linux Hosts. Verzeichnis /var/log.
</p></details>
	
---

Was ist stdout, stderr, stdin?
<details><summary>Antwort</summary>  
	 Standard Output, Standard Error Ausgabe und Standard Input Eingabe. 	
</p></details>

---

### Container sichern & beschränken
***

Wie kann `docker run -v /:/homeroot -it ubuntu bash` durch Normale User verhindert werden?
<details><summary>Antwort</summary>  
	 	nur `root` darf Container starten
</p></details>

---

Wie können verschiedene Mandanten getrennt werden?
<details><summary>Antwort</summary>  
	 	Mittels VM's
</p></details>
	
---

Wie kann der Ressourcenverbrauch von Containern eingeschränkt werden?
<details><summary>Antwort</summary>  
	 	https://docs.docker.com/config/containers/resource_constraints/#configure-the-default-cfs-scheduler 
</p></details>

---

### Kontinuierliche Integration
***

Welche Funktionen kann Jenkins übernehmen?
<details><summary>Antwort</summary>  
	 	CI, Modultests, Software bauen, Batch Jobs ausführen - z.B. Logs überprüfen
</p></details>

---

Wie baut man Modultests?
<details><summary>Antwort</summary>  
	 	Via Bash Scripts
</p></details>
	
---

Wie anders, als Manuell oder Zeitgesteuert könnten Jenkins Jobs auch gestartet werden?
<details><summary>Antwort</summary>  
	 	Durch Änderungen in einem Git Repository
</p></details>
