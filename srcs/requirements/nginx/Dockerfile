#build an image starting with debian image
FROM debian:buster

#UPDATE APT GET - PACKAGE MANAGER
RUN apt-get update -y
RUN apt-get upgrade -y

#INSTALL SERVER NGINX
RUN apt-get install -y nginx

#OPENSSL GENERATE KEY AND CERTIFICATE FILES
RUN apt-get install -y openssl

#GENERATE SSL KEY & CERTIFICATE
	# 	req — to specify we want to use -x509
	# 	x509 specify we want to create self-signed certificate
	# 	nodes skip option to secure our certificate with passphrase so nginx can read it
	# 	newrsa rsa:2048 — specifies that we want to generate both a new certificate and a new key with an RSA key of 2048 bits
	# 	keyout /etc/.../yourfile.key — specifies the location of the output .key file.
	# 	out /etc/.../yourfile.crt — specifies the location of the output .crt file.

RUN openssl req -x509 -newkey rsa:2048 -nodes -subj /C=FR \
        -keyout /etc/ssl/aandric.42.fr.key -out /etc/ssl/aandric.42.fr.crt;

#copy the .conf file 
COPY /conf/nginx.conf /etc/nginx/sites-available/aandric.42.fr.conf
#install the debian dependencies
RUN    ln -s /etc/nginx/sites-available/aandric.42.fr.conf /etc/nginx/sites-enabled/aandric.42.fr.conf
#add metadata to the image to describe that the container is listening on port 443
EXPOSE 443

RUN apt-get install -y dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

#set the default command for the container nginx run
CMD ["nginx", "-g", "daemon off;"]
