Microservices
-------------

### Übersicht 

    +---------------------------------------------------------------+
    !                                                               !	
    !    +--------------------+                                     !
    !    ! Micro Services     !                                     !       
    !    ! node.js            !                                     !       
    !    +--------------------+                                     !
    !                                                               !	
    ! Container                                                     !	
    +---------------------------------------------------------------+
    ! Container-Engine: Docker                                      !	
    +---------------------------------------------------------------+
    ! Gast OS: Ubuntu 16.04                                         !	
    +---------------------------------------------------------------+
    ! Hypervisor: VirtualBox                                        !	
    +---------------------------------------------------------------+
    ! Host-OS: Windows, MacOS, Linux                                !	
    +---------------------------------------------------------------+
    ! Notebook - Schulnetz 10.x.x.x                                 !                 
    +---------------------------------------------------------------+
    
### Beschreibung

Microservices sind ein Weg, Softwaresysteme so zu entwickeln und zu kombinieren, dass sie aus kleinen, unabhängigen Komponenten bestehen, die untereinander über das Netz interagieren. Das steht im Gegensatz zum klassischen, monolithischen Weg der Softwareentwicklung, bei dem es ein einzelnes, großes Programm gibt.

Wenn solch ein Monolith dann skaliert werden muss, kann man sich meist nur dazu entscheiden, vertikal zu skalieren (scale up), zusätzliche Anforderungen werden in Form von mehr RAM und mehr Rechenleistung bereitgestellt. Microservices sind dagegen so entworfen, dass sie horizontal skaliert werden können (scale out), indem zusätzliche Anforderungen durch mehrere Rechner verarbeitet werden, auf die die Last verteilt werden kann. 

In einer Microservices-Architektur ist es möglich, nur die Ressourcen zu skalieren, die für einen bestimmten Service benötigt werden, und sich
damit auf die Flaschenhälse des Systems zu beschränken. In einem Monolith wird alles oder gar nichts skaliert, was zu verschwendeten Ressourcen führt.


**Builden:**

Um den Microservices in ein Image zu verpacken, wechseln wir ins dieses Verzeichnis und bilden das Image mit Namen `microservice`

	cd /vagrant/microservice
	docker build -t microservice .

*Anmerkung*: das Verzeichnis `/vagrant` in der VM, ist das gleiche Verzeichnis wie `M300/docker/` auf dem Notebook. Vagrant mountet dieses automatisch beim start der VM.

**Aufruf:**

Den Microservice bzw. dessen Image können wir nun wie folgt starten. Wir starten zwei Container (Instanzen) zum Testen.

    docker run -d -p 32760:8081 --name microservice1 --rm microservice
    docker run -d -p 32761:8081 --name microservice2 --rm microservice
    
**Testen:**

Beide Container (Instanzen) sollten jetzt via Browser oder `curl` erreichbar sein.

    curl localhost:32760
    curl localhost:32761

    
