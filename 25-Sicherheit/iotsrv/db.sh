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

# Datenbank und User fuer IoT Daten anlegen 
mysql -uroot -pS3cr3tp4ssw0rd <<%EOF%
	create database if not exists sensoren;
	create user 'www-data'@'localhost' identified by 'mbed'; 
	grant usage on *.* to 'www-data'@'192.168.55.101' identified by 'mbed';
	grant all privileges on sensoren.* to 'www-data'@'192.168.55.101';
	flush privileges;
	use sensoren;
	create table data ( seq INT PRIMARY KEY AUTO_INCREMENT, poti FLOAT, light FLOAT, hall FLOAT, temp FLOAT, created TIMESTAMP DEFAULT CURRENT_TIMESTAMP );
	insert into data(poti, light, hall, temp) values ( 0.9, 0.8, 0.49, 25.2 );
	insert into data(poti, light, hall, temp) values ( 0.8, 0.7, 0.48, 25.1 );
%EOF%

# Restart fuer Konfigurationsaenderung
sudo service mysql restart

# Monitoring
sudo cp /vagrant/cron.root.db01 /var/spool/cron/crontabs/root && sudo chmod 600 /var/spool/cron/crontabs/root
sudo service cron reload
