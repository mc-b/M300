Fragen
======


### Kubernetes
***

Was ist Kubernetes?
<details><summary>Antwort</summary><p>    
	 Das im Juli 2014 gestartete Kubernetes (griechisch: Steuermann) stellt die derzeit populärste Container-Cluster-/Orchestrierungs-Lösung dar.
</p></details>

---

Was ist die Hauptaufgabe von Kubernetes?
<details><summary>Antwort</summary><p>    
     Kubernetes Hauptaufgabe ist die Verwaltung und Orchestrierung der Container innerhalb eines Clusters, der üblicherweise aus mindestens einem Kubernetes Master und multiplen Worker Nodes besteht.
</p></details>

---

Wer ist der Eigentümer von Kubernetes?
<details><summary>Antwort</summary><p>    
     Kubernetes ist mittlerweile bei der Cloud Native Computing Foundation (http://cncf.io) gehostet.
</p></details>

---

Was für eine Netzwerkstruktur verwendet Kubernetes?
<details><summary>Antwort</summary><p>    
     Kubernetes verwendet im Unterschied zu Docker eine flache Netzwerkstruktur. 
* Jeder Container kann mit jedem anderen ohne NAT kommunizieren.
* Alle Kubernetes Nodes können mit allen Containern (und in die andere Richtung) ohne NAT kommunizieren.
* Die IP, die ein Container von sich selbst sieht, ist auch die, die jeder andere Node oder Container im Netz von ihm sieht.
</p></details>

---

Über was Kommunizieren die Services von Nodes zu Nodes
<details><summary>Antwort</summary><p>    
     Über ein Overlay Netzwerk, welches auf jeder Node ein Subnetz zur Verfügung stellt.
</p></details>

---


### Objekte (Ressourcen)
***

Kubernetes Objekte (Ressourcen) werden im welchen Dateiformat beschrieben?
<details><summary>Antwort</summary><p>    
     YAML
</p></details>

---

Kubernetes Objekte (Ressourcen) können mittels Dashboard und welche CLI Tool verwaltet werden?
<details><summary>Antwort</summary><p>    
     kubectl
</p></details>

---

Mit was lassen sich Kubernetes Objekte (Ressourcen) gruppieren?
<details><summary>Antwort</summary><p>    
     Labels
</p></details>

---

Was sind Pods?
<details><summary>Antwort</summary><p>    
     Kleine Gruppe von Containern welche eng verbunden sind. Kleinste Einheit für Replikation und Platzierung (auf Node). “Logischer” Host für Container. Jeder Pods erhält genau eine IP-Adresse
</p></details>

---

Was sind Services?
<details><summary>Antwort</summary><p>    
     Eine Gruppe von Pods die zusammenarbeiten, Gruppiert mittels Label Selector. Erlaubt mittels unterschiedlichen Methoden auf den Service zuzugreifen, z.B. DNS Name. Definieren Zugriffsrichtlinien, z.B. Port Remapping für den Zugriff von ausserhalb des Clusters. 
</p></details>

---

Was ein Ingress?
<details><summary>Antwort</summary><p>    
    Ein API-Objekt, das den externen Zugriff auf die Dienste in einem Cluster verwaltet, in der Regel mittels HTTP. 
    Grob entspricht der Ingress Dienst dem Reverse Proxy Muster. 
</p></details>

---

Was sind Namespaces bzw. deren Aufgabe?
<details><summary>Antwort</summary><p>  
    Sie Unterteilen den gesamten K8s Cluster in logische Partitionen bzw. Bereiche. Vergleichbar mit Subdomains.
</p></details>

---

Was ist die Aufgabe eines ReplicaSets?
<details><summary>Antwort</summary><p>  
Stellt sicher, dass N Pods laufen sind es zu wenig, werden neue gestartet, sind es zu viele werden Pods beendet, gruppiert durch den Label Selector
</p></details>

---

Für was können Deployments verwendet werden?
<details><summary>Antwort</summary><p>  
Ermöglichen Deklarative Updates von Container Images in Pods. 
</p></details>

---


