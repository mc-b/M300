Microservices ohne und mit Container
====================================

Wir wollen die NodeJS App (Microservice) von [https://gitlab.com/ser-cal/Container-CAL-webapp_v1.git](https://gitlab.com/ser-cal/Container-CAL-webapp_v1.git) starten.

Ohne Container
--------------

VM erstellen 

    mkdir vm
    cd vm
    vagrant init ubuntu/focal64
    vagrant up
    vagrant ssh
    
Git Repository clonen und Versuch SW zu starten

    git clone https://gitlab.com/ser-cal/Container-CAL-webapp_v1.git
    cd Container-CAL-webapp_v1/App
    
    node app.js                                 # schlägt fehl, NodeJS etc. fehlt
    
Benötigte SW installieren 

    sudo apt-get update
    sudo apt-get install -y nodejs npm          # das sind 1 GB 
    
    npm install express --save
    npm install pug --save
    
    node app.js &                               # das geht
    curl localhost:8080                         # geht auch
    
    node app.js                                 # Fehlermeldung Port 8080 schon verwendet
    
    > events.js:174
    > Error: listen EADDRINUSE: address already in use :::8080
    
VM verlassen
    
    exit    
    
**Fazit**: einmal starten geht, mehrere Instanzen sind aber nicht möglich oder ich müsste jeweils `app.js` ändern.

Mit Container
-------------

VM neu erstellen

    vagrant destroy -f
    vagrant up
    vagrant ssh 
    
Container Umgebung, hier Docker installieren

    sudo apt-get update
    sudo apt-get install -y docker.io           # das sind 360 MB
    
Git Repository clonen 

    git clone https://gitlab.com/ser-cal/Container-CAL-webapp_v1.git
    cd Container-CAL-webapp_v1/App
    
Einmalig müssen wir die App packetieren (d.h. in ein Container-Image verpacken), dies geschieht mittels `docker` und einem verbereiteten `Dockerfile`. Details siehe [Container-CAL-webapp_v1](https://gitlab.com/ser-cal/Container-CAL-webapp_v1).

    sudo docker image build -t marcellocalisto/webapp_one:1.0 .
    sudo docker image ls
    
    > REPOSITORY                   TAG            IMAGE ID       CREATED         SIZE
    > marcellocalisto/webapp_one   1.0            f4e7bf13c7fa   6 seconds ago   195MB
    
Statt 1 GB für `NodeJS` und `npm` sind es jetzt, inkl. unserer App (Microservice), nur 195 MB.  

Nun können wir die, als Container Image, packetierte App (Microservice) starten und testen:  

    sudo docker container run -d --name app1 -p 8080:8080 marcellocalisto/webapp_one:1.0
    curl localhost:8080
    
Wurde die App (Microservice) so gestartet, reden wir von einem Container. Die Kontrolle über den Container übernimmt das Container Runtime (`Docker`).  

Um das zu überprüfen, können wir einen Docker Befehl oder Linux Befehl verwenden:

    sudo docker container ps
    
    > ...   marcellocalisto/webapp_one:1.0   "docker-entrypoint.s…"   ...   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   app1
    
oder wie schauen uns die Prozesshierarchie an:

    pstree -n -p -T -A
    
    > systemd(1)-+-systemd-journal(350)
    >       `-containerd-shim(4742)---sh(4763)---node(4795)     # hier läuft, gestartet vom Container Runtime containerd (Bestandteil von Docker) der Container        
    
Gehen aber auch weitere Instanzen? 

Ja, weil das Portmapping kann an das Container Runtime (Docker) delegiert werden. Die App (Microservice) muss dazu nicht verändert werden.    
    
    sudo docker container run -d --name app2 -p 8081:8080 marcellocalisto/webapp_one:1.0
    curl localhost:8081
    
Warum kann ich die App aber mehrmals starten? Nur am Portmapping kann es nicht liegen, siehe [Linux Namespaces](https://github.com/mc-b/duk/tree/master/linuxns).

Oder wir wechseln einfach mal in einen Container und schauen uns die Netzwerk-Adapter an.

    sudo docker exec -it app1 bash
    
Jetzt sind wir im Container, dort fehlen aber einige Befehle, welche wir zuerst installieren müssen:

    apt update
    apt install -y iproute2
    
Jetzt können wir uns die Netzwerk-Adapter anschauen. Die VM hat eine IP-Adresse 10.0.2.15.
    
    ip addr
    
    > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    >    inet 127.0.0.1/8 scope host lo
    > 10: eth0@if11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    >    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
    
Jeder Container verfügt, vereinfacht, über:
* einen eigenen Netzwerk-Adapter
* ein eigenes Dateisystem (darum musten wir zuerst SW installieren)
* eine eigene Prozesshierarchie.    
        
