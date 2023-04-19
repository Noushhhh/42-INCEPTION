# Build an image based on the Debian Buster base image
FROM debian:buster

# Update the package manager apt-get
RUN apt-get update -y
RUN apt-get upgrade -y

# Install dumb-init which helps to manage zombie processes.
# This is useful when using Docker and especially infrastructure-oriented containers + lightweight
RUN apt-get install -y dumb-init

# Install the nginx server
RUN apt-get install -y nginx

# Install SSL to manage SSL certificates and keys
RUN apt-get install -y openssl

# Generate an SSL key and certificate for the domain andric.42.fr
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

# Copy the nginx configuration file to the container
COPY /conf/nginx.conf /etc/nginx/sites-available/aandric.42.fr.conf

# Install the Debian dependencies with a symbolic link
RUN ln -s /etc/nginx/sites-available/aandric.42.fr.conf /etc/nginx/sites-enabled/aandric.42.fr.conf

# Expose port 443, on which the container listens
EXPOSE 443

# Install dumb-init again (in case it wasn't installed earlier)
RUN apt-get install -y dumb-init

# Use dumb-init as the container's entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Set the default command for the container to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
