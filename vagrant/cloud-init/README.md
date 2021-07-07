Vagrant mit Cloud-init
======================

[Cloud-init](https://cloudinit.readthedocs.io/en/latest/) ist die Multi-Distributionsmethode für die plattformübergreifende Initialisierung von Cloud-Instanzen. 

Es wird von allen grossen öffentlichen Cloud-Anbietern, Bereitstellungssystemen für private Cloud-Infrastrukturen und Bare-Metal-Installationen unterstützt.

Vagrant unterstützt "experimentell" [Cloud-init](https://cloudinit.readthedocs.io/en/latest/).

Mit einem kleinen Trick, können aber viele Vagrant Boxen, mit Cloud-init verwendet werden.

Das Vorgehen ist dabei wie folgt:
* Erstellt eine Cloud-init Datei z.B. `99-cloud-init.cfg`
* Erstellt ein Vagrantfile `vagrant init ubuntu/focal64` 
* Erweitert das Vagrantfile um Portweiterleitung, fixe IP-Adresse, mindestens 2 GB RAM. Siehe Beispiel in diesem Verzeichnis.
* Erweitert die `SHELL` Konfiguration wie folgt:

<pre>
    config.vm.provision "shell", inline: <<-SHELL
       cp /vagrant/99-cloud-init.cfg /etc/cloud/cloud.cfg.d/
       cloud-init clean
       shutdown -r now
    SHELL
</pre>

Grundsätzlich unterstützen viele Linux Systeme Cloud-init. Die Unterstützung ist meistens so Implementiert, dass beim Aufstarten des Betriebssystem, geprüft wird ob Cloud-init bereits durchgelaufen ist. Wenn nicht wird es ausgeführt. Dabei werden die Dateien im Verzeichnis `/etc/cloud/cloud.cfg.d/` durchlaufen. Die obige Konfiguration macht sich diesen Umstand zu Nutze und erzwingt ein nochmaliges Durchlaufen von Cloud-init, neu mit unserere zusätzlichen Konfigurationsdatei `99-cloud-init.cfg`.

Beispiele für `99-cloud-init.cfg` Scripts sind:

    #cloud-config - Installiert den nginx Web Server
    packages:
     - nginx

- - -

    #cloud-config - Erstellt eine Intro Seite und installiert den Apache Web Server mit dieser Seite
    packages:
     - git
    runcmd:
     - git clone https://github.com/mc-b/lernmaas /home/vagrant/lernmaas
     - git clone https://github.com/mc-b/M300 /home/vagrant/M300
     - cd /home/vagrant/M300/vagrant/cloud-init/
     - sudo bash -x /home/vagrant/lernmaas/helper/intro
     
Jeweiliges Beispiel kopieren und in Datei `99-cloud-init.cfg` einfügen, VM zerstören und neu bauen.
     
Der aktuelle Fortschritt kann mittels Ausgabe des Cloud-init Logs angeschaut werden:

    vagrant ssh -c '(sudo tail -f /var/log/cloud-init-output.log)'


***
Kubernetes
----------

Mittels Cloud-init lässt sich auch eine Kubernetes Umgebung, basierend auf [microk8s](https://microk8s.io/), installieren.

Das Cloud-init Script ist wie folgt:

    #cloud-config
    users:
      - name: ubuntu
        sudo: ALL=(ALL) NOPASSWD:ALL
        groups: users, admin
        home: /home/ubuntu
        shell: /bin/bash
        lock_passwd: false
        plain_text_passwd: 'password'        
    # login ssh and console with password
    ssh_pwauth: true
    disable_root: false    
    packages:
      - unzip
    runcmd:
      - sudo snap install microk8s --classic
      - sudo usermod -a -G microk8s ubuntu
      - sudo microk8s enable dns 
      - sudo mkdir -p /home/ubuntu/.kube
      - sudo microk8s config -l >/home/ubuntu/.kube/config
      - sudo microk8s config -l >/vagrant/config      
      - sudo chown -f -R ubuntu /home/ubuntu/.kube
      - sudo snap install kubectl --classic  
      - sudo microk8s kubectl apply -f https://raw.githubusercontent.com/mc-b/duk/master/addons/dashboard-skip-login-no-ingress.yaml

Neu wird ein User `ubuntu` mit Password `password` angelegt. Mittels ssh und dem neuen User können wir uns mit der VM verbinden:

    ssh ubuntu@localhost -p 2222
    
Zusätzlich steht das Kubernetes Dashboard via HTTPS und Port 8433 zur Verfügung. Ein Token ist nicht erforderlich, die Anmeldung kann übersprungen werden.

* [https://localhost:8443](https://localhost:8443)  

**Links**

* [Offizielle Cloud-init Beispiele](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)
* [lernMAAS und Cloud-init in der Public Cloud](https://github.com/mc-b/lernmaas/tree/master/doc/Cloud)
