Kubernetes (k8s) hands-on
=========================

Container in Kubernetes lauffähig, d.h. via YAML Dateien beschrieben.

[![](https://img.youtube.com/vi/PH-2FfFD2PU/0.jpg)](https://www.youtube.com/watch?v=PH-2FfFD2PU)

Kubernetes in 5 Minuten auf YouTube

---

Es soll ein Web Server gestartet werden und im Kubernetes Cluster mittels <ip-cluster:/<port> erreichbar sein.

Die Deklarationen dazu, sollen als YAML Dateien verfügbar sein.

Der Einfachheit halber, verwenden wir nur Pods (beinhalten Container) und Services (Port veröffentlichen).

### Installation Kubernetes
***

Für die Installation verwenden Sie die Anleitung vom Projekt:

* [Docker und Kubernetes – Übersicht und Einsatz](https://github.com/mc-b/duk)

**ACHTUNG**: es wird ein PC oder Notebook mit mindestens 16 GB RAM und 40 GB HD benötigt.

Alternative Installationen sind im Projekt [lernkube](https://github.com/mc-b/lernkube#alternativen) beschrieben.

### Erzeugen der Ressourcen (Pod, Service) mittels `kubectl run`
***

Wir Erzeugen Pods und Services in einem eigenen Namespace `test` so sind sie nachher einfach wieder zu entfernen.

	kubectl create namespace test
	
Erzeugen eines Pod's, hier der Apache Web Server.

Die Option --restart=Never erzeugt nur einen Pod. Ansonsten wird ein Deployment erzeugt.	
	
	kubectl run apache --image=httpd --restart=Never --namespace test

Ausgabe der Erzeugten Ergebnisse und die YAML Datei welche den Pod beschreibt. 

**Schlussfolgerung**: intern Erzeugt Kubernetes zu jeder Ressource immer eine YAML Datei. Da machen wir uns Zunutze um die YAML Datei nicht manuell Erstellen zu müssen. 

	kubectl get pod apache -o yaml --namespace test
	
Zu dem Pod apache Erzeugen wir einen Service. Dadurch wird der Web Server von aussen sichtbar.

Der Port 80 wird von Kubernetes automatisch auf den nächsten freien Port gemappt

	kubectl expose pod/apache --type="LoadBalancer" --port 80 --namespace test
	
Auch hier geben wir wieder die YAML Datei, für später aus:
	
	kubectl get service apache -o yaml --namespace test
	
Und kontrollieren ob ein Pods und ein Service erzeugt wurde:

	kubectl get pods,service apache --namespace test
	
Mittels der IP-Adresse des Clusters (default: 192.168.137.100) und des Port können wir dann auf den Services zugreifen.

Diese Informationen können wir auch mittels eines kleinen Scripts erfragen:
	
	kubectl config view -o=jsonpath='{ .clusters[0].cluster.server }' | sed -e 's/https:/http:/' -e "s/6443/$(kubectl get service --namespace test apache -o=jsonpath='{ .spec.ports[0].nodePort }')/"
	
### Erzeugen der Ressourcen (Pod, Service) mittels `kubectl apply -f YAML`
***	

Nehmen wir nun die Ausgabe von 
	
	kubectl get pod apache -o yaml --namespace test
	kubectl get service apache -o yaml --namespace test	
	
haben wir unsere Vorlage für die YAML Dateien um die Ressourcen beliebig oft erzeugen zu können.

Aus der Ausgabe nehmen wir alles raus, was nicht zwingend benötigt wird, was zu folgenden Ergebnissen führt:

**apache-pod.yaml**

```YAML

apiVersion: v1
kind: Pod
metadata:
  labels:
    app.kubernetes.io/name: apache
  name: apache
spec:
  containers:
  - image: httpd
    name: apache
```

**apache-service.yaml**

```YAML

apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: apache
  name: apache
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app.kubernetes.io/name: apache
  type: LoadBalancer
```

Speichern wir diese, z.B. im Verzeichnis `apache` können wir diese mittels einem Befehl erzeugen. Vorher erzeugen wir aber, wie vorher, ein Namespace.

	kubectl create namespace yaml
	kubectl apply -f apache -n yaml
	
**Hinweis**: den Namespace schreiben wir extra nicht in die YAML Dateien rein, damit wir die gleichen Pod/Services in unterschiedlichen Namespaces erzeugen können (z.B. für verschiedene Mandanten).

Bleibt noch die Ausgabe des URL mittels

	kubectl config view -o=jsonpath='{ .clusters[0].cluster.server }' | sed -e 's/https:/http:/' -e "s/6443/$(kubectl get service --namespace yaml apache -o=jsonpath='{ .spec.ports[0].nodePort }')/"



	
	