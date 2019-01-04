Tools
-----

Um Konfigurationsdateien mit dem "Infrastruktur als Code" Ansatz zu bearbeiten, eigen sich u.a. folgende Tools:


### sed

sed (von stream editor) ist ein nicht-interaktiver Texteditor für die Verwendung auf der Kommandozeile oder in Skripten. sed zählt zu den "Urgesteinen" in der Unix- / Linux-Welt und ist quasi in jeder Linux-Installation (auch Minimalinstallationen) enthalten.

**Beispiele:**

Ersetzen von Text in einer Datei:

    sed 's/Anton/Berta/g' Textdatei 

Entfernen von Zeilen: hier alle Zeilen welche mit # beginnen.

    sed '/^#/d' Textdatei 

MySQL Port oeffnen

    sudo sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

Für ^, \s* siehe [Regulärer Ausdruck](https://de.wikipedia.org/wiki/Regul%C3%A4rer_Ausdruck#Regul.C3.A4re_Ausdr.C3.BCcke_in_der_Praxis) und [The s Command](https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html)

### cat

cat ist ursprünglich zum Zusammenfügen von Dateien gedacht (von concatenate = verketten, verknüpfen). Häufig wird cat aber als (einfacher) Pager zum Anzeigen von Dateiinhalten im Terminal eingesetzt (was letztendlich dem "Verketten" von Dateiinhalten mit dem Bildschirm entspricht).

**Beispiel:**

Schreiben einer Zwischendatei und Übergabe dieser an ein Nachfolgendes Programm. `$$` ist die Prozess Nummer.

	cat <<%EOF% >/tmp/$$
		CREATE USER 'root'@'192.168.55.101' IDENTIFIED BY 'admin';
		GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.55.101';
		FLUSH PRIVILEGES;
	%EOF%
	
	mysql -uroot -pS3cr3tp4ssw0rd </tmp/$$

### cut

Der Befehl cut extrahiert spaltenweise Ausschnitte aus Textzeilen. So können bspw. aus einer Logdatei irrelevante Informationen entfernt oder CSV-Dateien bearbeitet werden.

**Beispiele:**

Ausgabe nur der Benutzernamen aus der `/etc/passwd` Datei

    cut -d: -f1 /etc/passwd 
    
Ausgabe aller Prozess Nummern

    ps huax | cut -c 9-14 
    
Durch eine Kombination von Befehlen kann cut auf jedes Zeichen einer Datei zugreifen. Mit dem folgenden Befehl wird das dritte Wort der 6. Zeile der Datei datei.txt extrahiert. Es werden dabei zunächst mit head die ersten 6 Zeilen ausgeschnitten, dann mit tail die letzte dieser verbleibenden Zeilen und schließlich mit cut deren drittes Wort:
    
    cat datei.txt | head -6l | tail -1l | cut -d" " -f3

## ln

ln steht für link und erzeugt eine Verknüpfung zu einer Datei oder einem Verzeichnis. Man kann danach auf eine Datei nicht nur über ihren ursprünglichen Namen bzw. Pfad, sondern auch über den Namen des Links zugreifen. 

Man unterscheidet zwischen Hardlinks und symbolischen (oder Soft-) Links. 
* Ein Hardlink ist einfach ein Verzeichniseintrag mit einem Namen, der auf eine Datei zeigt. Jede Datei hat immer mindestens einen Hardlink, denn ansonsten könnte man sie im Dateisystem nicht finden.
* Symbolische Verknüpfungen (oder "Softlinks") wurden geschaffen, um diese Unzulänglichkeit der Hardlinks zu umgehen. Sie funktionieren ähnlich wie die HTML-Links auf Webseiten. Ein symbolischer Link ist einfach eine kleine Datei bei der das l-Bit gesetzt ist, und die den Pfad des Zieles enthält.

**Beispiele:**

Datei erstellen und dann mit einem Hardlink verknüpfen:

	cat <<%EOF% >zahlen
	eins
	zwei
	drei
	%EOF%
	ln zahlen numbers
	
	ubuntu@web01:~$ ls -li
	total 8
	280065 -rw-rw-r-- 2 ubuntu ubuntu 15 Feb 11 12:45 numbers
	280065 -rw-rw-r-- 2 ubuntu ubuntu 15 Feb 11 12:45 zahlen
	ubuntu@web01:~$ cat numbers
	eins
	zwei
	drei
	ubuntu@web01:~$ cat zahlen
	eins
	zwei
	drei
	
Apache Modul mittels eines Symbolischen Links freischalten:

    cd /etc/apache2/conf-enabled/
    ln -s ../conf-available/adminer.conf .

### Links

* [sed](https://wiki.ubuntuusers.de/sed/)
* [cat](https://wiki.ubuntuusers.de/cat/)
* [cut](https://wiki.ubuntuusers.de/cut/)
* [ln](https://wiki.ubuntuusers.de/ln/)
