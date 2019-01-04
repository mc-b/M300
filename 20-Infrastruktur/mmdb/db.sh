#!/bin/bash
#
#	Datenbank installieren und Konfigurieren
#

# root Password setzen, damit kein Dialog erscheint und die Installation haengt!
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password S3cr3tp4ssw0rd'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password S3cr3tp4ssw0rd'

# Installation
sudo apt-get install -y mysql-server

# MySQL Port oeffnen
sudo sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# User fuer Remote Zugriff einrichten - aber nur fuer Host web 192.168.55.101
mysql -uroot -pS3cr3tp4ssw0rd <<%EOF%
	CREATE USER 'root'@'192.168.55.101' IDENTIFIED BY 'admin';
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.55.101';
	FLUSH PRIVILEGES;
%EOF%

# Restart fuer Konfigurationsaenderung
sudo service mysql restart
