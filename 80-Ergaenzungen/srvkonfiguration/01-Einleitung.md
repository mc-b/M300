Einleitung
----------

	ubuntu-xenial
	    State: running
	     Jobs: 0 queued
	   Failed: 0 units
	    Since: Sat 2017-02-04 07:58:03 UTC; 10min ago
	   CGroup: /
	           ├─init.scope
	           │ └─1 /sbin/init
	           ├─system.slice
	           │ ├─mdadm.service
	           │ │ └─1278 /sbin/mdadm --monitor --pid-file /run/mdadm/monitor.pid --daemonise --scan --syslog
	           │ ├─dbus.service
	           │ │ └─1229 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
	           │ ├─cron.service
	           │ │ └─1151 /usr/sbin/cron -f
	           │ ├─lvm2-lvmetad.service
	           │ │ └─470 /sbin/lvmetad -f
	           │ ├─virtualbox-guest-utils.service
	           │ │ └─1372 /usr/sbin/VBoxService
	           │ ├─apache2.service
	           │ │ ├─3311 /usr/sbin/apache2 -k start
	           │ │ ├─3314 /usr/sbin/apache2 -k start
	           │ │ └─3315 /usr/sbin/apache2 -k start
	           │ ├─iscsid.service
	           │ │ ├─1144 /sbin/iscsid
	           │ │ └─1145 /sbin/iscsid
	           │ ├─networking.service
	           │ │ └─996 /sbin/dhclient -1 -v -pf /run/dhclient.enp0s3.pid -lf /var/lib/dhcp/dhclient.enp0s3.leases -I -df /var/lib/dhcp
	           
laufende Dienste auf einem Linux System

- - -          

Ein Dienst ist ein Programm, das beim Start des Rechners automatisch ausgeführt wird und im Hintergrund darauf wartet, seine Aufgabe zu erledigen. 

Ein Dienst besitzt meist keine grafische Oberfläche und arbeitet ohne Interaktion des Benutzers. 

Die bekanntesten Dienste sind sicherlich Web-, Mail- oder Datenbank-Server. Aber auch die Hardwareerkennung oder das automatische Einbinden (Mounten) von z.B. USB-Sticks wird durch Dienste erledigt. 

Prinzipiell gibt es also zwei Arten von Diensten: 
* interne für beim Systemstart relevante bzw. hardwarenahe Aufgaben
* vom Benutzer nachinstallierte Dienste, zu denen in der Regel alle Serverdienste gehören.

Im Computer-Jargon werden Dienste traditionell auch als "Daemon" (im Sinne eines guten Geistes) bezeichnet. Der Buchstabe d findet sich daher häufig auch als letzter Buchstabe in der Programmbezeichnung wieder, so z.B. bei der Serverkomponente sshd von SSH.

### Init-Systeme

Um das geordnete Starten und Beenden der Dienste kümmert sich ein Init-System. Dies ist normalerweise der erste gestartete Prozess und hat damit die Prozess-ID 1.

Ursprünglich übernahm diese Aufgabe auf Linux-Systemen [SysVinit](https://wiki.ubuntuusers.de/SysVinit/). Dieses startet die Dienste nacheinander in einer festgelegten Reihenfolge. Das macht den Startvorgang zuverlässig und leicht kontrollierbar, aber auch langsam. Mit dem parallelen Start von Diensten lässt sich der Startvorgang entscheidend beschleunigen, was insbesondere auf Desktop-Rechnern und Notebooks praktische Vorteile bietet.

**Ab Ubuntu 15.04 ist systemd bei Ubuntu vorinstalliert**

### Starten und Beenden von Diensten

Stoppen und Starten des Apache Web Servers, alte und neue Variante:
 
	sudo service apache2 stop
	sudo service apache2 start
	
	sudo systemctl stop apache2
	sudo systemctl start apache2

Status aller Services abfragen:

	sudo service --status-all
	
	sudo systemctl status
	
### Start-/Stopp-Skripte

Je nach verwendetem System, findet man Start-/Stopp-Skripte an folgenden Orten:

* Systemd: /etc/systemd/system/ (benutzerdefinierte) oder /lib/systemd/system/ (systemeigene)
* Upstart: .conf-Dateien im Ordner /etc/init/
* SysVinit: alle Dateien im Ordner /etc/init.d/

### Links

* [Wiki ubuntuusers.de](https://wiki.ubuntuusers.de/Dienste/)
* [SysVinit](https://wiki.ubuntuusers.de/SysVinit/)
* [Upstart](https://wiki.ubuntuusers.de/Upstart/)
* [systemd](https://wiki.ubuntuusers.de/systemd/)

