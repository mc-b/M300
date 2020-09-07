DHCP Server Testumgebung
------------------------

* 1 Server mit DHCP und DNS Server
* 2 Worker wo die IP Adresse vom Server holen

### Probleme

**Vagrant erstellt immer einen DHCP Server in Virtualbox.**

* `virtualbox__dhcp_server: false` sollte dies verhindern, siehe Issue [10983](https://github.com/hashicorp/vagrant/pull/10983/commits).

Lösung

In VM Adapter herunterfahren und neu starten

    sudo ifdown enp0s8
    sudo ifup enp0s8

Vorher DHCP Server in Virtualbox deaktiveren, bzw. löschen (siehe unten).

**Das Routing ist anzupassen.**

Jetzt wird 10.0.2.2 (enp0s3 Vagrant Adapter) als Default Gateway verwendet.

### DHCP Server testen

Zeige die verwendeten IP-Adressen an. Es sollten `worker1` und `worker2` erscheinen.    

    dhcp-lease-list --lease /var/lib/dhcp/dhcpd.leases
    
Welche IP-Adressen bzw. Server sind aktiv

    nmap -v -sP 192.168.50.0/24

### DNS Server testen

    vagrant ssh master
    
    dig @192.168.50.2 example.com
    
Liefert 192.168.50.2, weil DNS Server lokal vorhanden.
    
    dig example.com
    
Liefert die effektive IP von example.com im Internet.   
    

### Virtualbox Befehle

    vboxmanage dhcpserver remove --ifname vboxnet0
    
    vboxmanage list hostonlyifs
    vboxmanage list dhcpservers
    
    
### Links

* [Ubuntu Server]
* [DHCP Server](https://ubuntu.com/server/docs/network-dhcp)
* [DNS Server](https://ubuntu.com/server/docs/service-domain-name-service-dns)
* [dig Wiki](https://ubuntu.com/server/docs/service-domain-name-service-dns)