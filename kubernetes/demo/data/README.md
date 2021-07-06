Gemeinsames Datenverzeichnis
----------------------------

Gemeinsames Datenverzeichnis welches von Kubernetes Master und Nodes genützt wird.

### Aufbau

    +---------------------------------------------------------------+
    ! Docker Container Verbinden sich mit data-claim, z.B.          !	
    !  volumes:                                                     !
    ! - name: container-storage                                     !                                     
    !    persistentVolumeClaim:                                     !
    !     claimName: data-claim                                     !	
    +---------------------------------------------------------------+
    ! Persistent Volume Claim data-claim fordert Speicher von Volume!	
    +---------------------------------------------------------------+
    ! Persistent Volume: data-volume zeigt auf /data in VM          !	
    +---------------------------------------------------------------+
    ! Vagrant mounted data Verzeichnis im aktuellen Verzeichnis     !
    ! config.vm.synced_folder "data", "/data"                       !                 
    +---------------------------------------------------------------+
    
#### Vagrant Installation

Keine Aktionen notwendig. 

Im Vagrantfile wird das PersistentVolume und PersistenVolumeClaim erzeugt:

	kubectl apply -f /vagrant/data/
	
Die Pods verwenden `PersistentVolumeClaim` und müssen nicht geändert werden.

Für neue Pods ist, statt ein `hostPath` als Speicherort `persistentVolumeClaim` einzutragen und ein `subPath`, welcher festlegt in welchem Unterverzeichnis vom Persistent Volume die Daten abgelegt werden.

Beispiel aus `devops/gogs.yaml`:

	    # Volumes im Container
	    volumeMounts:
	    - mountPath: "/data"
	      subPath: gogs           
	      name: "gogs-storage"
	  # Volumes in Host
	  volumes:
	  - name: gogs-storage
	    persistentVolumeClaim:
	     claimName: data-claim  
		    
    