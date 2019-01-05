#
#	Einfache MySQL Umgebung
#
FROM ubuntu:14.04
MAINTAINER Marcel mc-b Bernet <marcel.bernet@ch-open.ch>

# root Password setzen, damit kein Dialog erscheint und die Installation haengt!
RUN echo 'mysql-server mysql-server/root_password password S3cr3tp4ssw0rd' | debconf-set-selections 
RUN echo 'mysql-server mysql-server/root_password_again password S3cr3tp4ssw0rd' | debconf-set-selections 

# Installation
RUN apt-get update && apt-get install -y mysql-server

# mysql config - Port fuer alle Hosts oeffnen
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

#HEALTHCHECK --interval=5m --timeout=3s CMD curl -f localhost:3306 || exit 1

EXPOSE 3306

VOLUME /var/lib/mysql

CMD ["mysqld"]
