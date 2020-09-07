DHCP Server Testumgebung
------------------------

* 1 Server mit DHCP Server
* 2 Worker wo die IP Adresse vom Server holen

### Probleme

Vagrant erstellt und starten immer einen DHCP Server in Virtualbox.

* `virtualbox__dhcp_server: false` sollte dies verhindern.

Lösung

In VM Adapter herunterfahren und neu starten

    sudo ifdown enp0s8
    sudo ifup enp0s8

Vorher DHCP Server in Virtualbox deaktiveren

### Virtualbox Befehle

    vboxmanage dhcpserver remove --ifname vboxnet0
    
    vboxmanage list hostonlyifs
    vboxmanage list dhcpservers
    
    
