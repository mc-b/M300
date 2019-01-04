Fragen
======

### Firewall und Reverse Proxy

{% exercise %}
* Das ist der Unterschied zwischen einem Web Server und einen Reverse Proxy?
{% solution %}    
	 Web Server handelt HTML Seiten direkt ab, Reverse Proxy dient als Stellvertretter für einen Web Server o.ä.	
{% endexercise %}

{% exercise %}
* Was verstehen wir unter einer "White List"?
{% solution %}    
	 	Eine White List, fasst im Gegensatz zu einer Black List, Vertrauenswürdige Elemente, z.B. Server zusammen.
{% endexercise %}
	
{% exercise %}
* Was wäre die Alternative zum Absichern der einzelnen Server mit einer Firewall?
{% solution %}    
	 	Eine Zentrale Firewall
{% endexercise %}

### ssh

Was ist der Unterschied zwischen der id_rsa und id_rsa.pub Datei?
{% solution %}    
	 Private und Public Key 	
{% endexercise %}

{% exercise %}
Wo darf ein SSH Tunnel nicht angewendet werden?
{% solution %}    
	 In der Firma	
{% endexercise %}

{% exercise %}
Für was dient die Datei `authorized_keys`?
{% solution %}    
	 Beinhaltet die Public Key von allen wo ohne Password auf System dürfen
{% endexercise %}
	
{% exercise %}
Für was dient die Datei `known_hosts`?
{% solution %}    
	 Liste der Systeme wo ich mich via ssh Verbunden habe - steht nicht in Doku -> Googeln	
{% endexercise %}

