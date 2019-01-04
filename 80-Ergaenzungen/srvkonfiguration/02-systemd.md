systemd
-------

	[Unit]
	Description=OpenBSD Secure Shell server
	After=network.target auditd.service
	ConditionPathExists=!/etc/ssh/sshd_not_to_be_run
	
	[Service]
	EnvironmentFile=-/etc/default/ssh
	ExecStart=/usr/sbin/sshd -D $SSHD_OPTS
	ExecReload=/bin/kill -HUP $MAINPID
	KillMode=process
	Restart=on-failure
	RestartPreventExitStatus=255
	Type=notify
	
	[Install]
	WantedBy=multi-user.target
	Alias=sshd.service

Konfiguration des OpenBSD Secure Shell server

- - -

[systemd](https://wiki.ubuntuusers.de/systemd/) ist ein System- und Sitzungs-Manager (Init-System), der für die Verwaltung aller auf dem System laufenden Dienste über die gesamte Betriebszeit des Rechners, vom Startvorgang bis zum Herunterfahren, zuständig ist. 

Prozesse werden dabei immer (soweit möglich) parallel gestartet, um den Bootvorgang möglichst kurz zu halten.

Systemd wird über Dateien mit einem INI-Datei-ähnlichen Format konfiguriert. In der Terminologie von systemd sind dies "Units". 

Bei Ubuntu vorinstallierte Units sind im Ordner `/lib/systemd/system/` gespeichert. Falls sich jedoch eine Unit mit gleichem Namen im Verzeichnis `/etc/systemd/system/` befindet, so wird diese bevorzugt und jene unterhalb von /lib ignoriert. Damit hat man die Möglichkeit, eine Unit an eigene Gegebenheiten anzupassen, ohne dass man befürchten muss, dass sie bei einer Systemaktualisierung überschrieben wird.

### Links

* [Wiki ubuntuusers.de](https://wiki.ubuntuusers.de/systemd/) 