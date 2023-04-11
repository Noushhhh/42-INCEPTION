FROM debian:buster

#SAME ARGUMENTS AS IN DOCKER COMPOSE

ARG DB_USER
ARG DB_DATABASE
ARG DB_PASSWORD
ARG DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD

#INSTALL MARIADB SERVER
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server

# set user mysql as owner
RUN mkdir -p /var/run/mysql
RUN chown -R mysql:mysql /var/run/mysql

RUN service mysql start \
&& mysql -u root -e 


COPY ./conf/mariadb.conf ./etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306


RUN apt-get install -y dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["mariadb", "--bind-address=0.0.0.0"]
