Anacron 
-------

	ubuntu@ubuntu-xenial:~$ ls -ld /etc/cron*
	drwxr-xr-x 2 root root 4096 Feb  4 07:58 /etc/cron.daily
	drwxr-xr-x 2 root root 4096 Jan 19 15:51 /etc/cron.hourly
	drwxr-xr-x 2 root root 4096 Jan 19 15:51 /etc/cron.monthly
	drwxr-xr-x 2 root root 4096 Jan 19 15:53 /etc/cron.weekly

Anacron Verzeichnisse

- - -

Cron startet einzelne Cronjobs immer nur zu den eingetragenen Zeiten. Legt man also einen Cronjob an, der täglich um 18.00 Uhr ausgeführt wird, so wird der Job an diesem Tag nur ausgeführt, wenn der Rechner um Punkt 18 Uhr angeschaltet war. Für Jobs, die regelmäßig ausgeführt werden müssen, wobei der Rechner nicht durchgehend läuft, ist Cron daher nicht ideal. Wenn man Pech hat, wird z.B. eine wichtige Datensicherung ("backup") verpasst.

Als Ergänzung zu Cron bietet sich daher Anacron an. Anacron ist ein cron-ähnlicher Taskplaner, allerdings erfordert er nicht das kontinuierliche Laufen des Systems. Er kann zum Ausführen von täglich, wöchentlich oder monatlich (und ab Ubuntu 14.04 auch stündlich) anstehenden Aufträgen verwendet werden, die normalerweise von cron ausgeführt werden.

Anstatt einer Crontab muss nur das auszuführende Skript oder Programm in das entsprechende Verzeichnis des Anacron-Dienstes kopiert oder verlinkt werden.

* **/etc/cron.hourly/** - stündlich auszuführen, erst ab Ubuntu 14.04
* **/etc/cron.daily/** - täglich auszuführen
* **/etc/cron.weekly/** - wöchentlich auszuführen
* **/etc/cron.monthly/** - monatlich auszuführen

Die Namen der Verzeichnisse sprechen für sich. Skripte, die dort abgelegt sind, werden auch durch den Anacron-Dienst ausgeführt. Am besten schaut man sich kurz die Skripte in diesen Verzeichnissen an, bevor man selber dort etwas ablegt.

### Links

* [Wiki ubuntuusers.de - ca. ab Mitte Seite](https://wiki.ubuntuusers.de/Cron/) 

