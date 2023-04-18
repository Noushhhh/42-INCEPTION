#build an image starting with debian image
FROM debian:buster

#UPDATE APT GET - PACKAGE MANAGER
RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y dumb-init

#INSTALL SERVER NGINX
RUN apt-get install -y nginx

#OPENSSL GENERATE KEY AND CERTIFICATE FILES
RUN apt-get install -y openssl

#GENERATE SSL KEY & CERTIFICATE to domain andric.42.fr
	# openssl: invokes the OpenSSL command-line tool.
	# req: specifies that the command is for generating a certificate request.
	# -x509: indicates that the command is for generating a self-signed certificate.
	# -newkey rsa:2048: specifies that a new RSA private key with a length of 2048 bits should be generated for the certificate.
	# -nodes: indicates that the private key should not be encrypted with a passphrase.
	# -subj /C=FR: specifies the subject information for the certificate request, in this case setting the country code to France.
	# -keyout /etc/ssl/aandric.42.fr.key: specifies the path and filename for the private key file.
	# -out /etc/ssl/aandric.42.fr.crt: specifies the path and filename for the self-signed certificate file.

RUN openssl req -x509 -newkey rsa:2048 -nodes -subj /C=FR \
        -keyout /etc/ssl/aandric.42.fr.key -out /etc/ssl/aandric.42.fr.crt;

#copy the nginx conf file 
COPY /conf/nginx.conf /etc/nginx/sites-available/aandric.42.fr.conf
#install the debian dependencies
# RUN    	ln -s /etc/nginx/sites-available/aandric.42.fr.conf /etc/nginx/sites-enabled/aandric.42.fr.conf
RUN 	ln -s /etc/nginx/sites-available/aandric.42.fr.conf /etc/nginx/sites-enabled/

#add metadata to the image to describe that the container is listening on port 443
EXPOSE 443

RUN apt-get install -y dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#set the default command for the container nginx run
CMD ["nginx", "-g", "daemon off;"]
