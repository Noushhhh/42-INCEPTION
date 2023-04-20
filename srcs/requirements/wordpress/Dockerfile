FROM debian:buster

# Update and upgrade the package list in the image
RUN apt-get update -y \
&& apt-get upgrade -y

# Install Curl and Less command line utilities
RUN apt-get install curl less -y

# Install PHP
RUN apt-get install -y php

# Install PHP-FPM (FastCgi process manager)
# PHP-FPM is a protocol that defines how a web server (e.g. nginx) communicates 
# with a CGI program (e.g. php) about the received request
RUN apt-get install -y php-fpm

# Install the old MySQL driver (mysql) and the improved driver (mysqli)
RUN apt-get install -y php-mysql \
&& apt-get install -y php-mysqli

# Install the MariaDB client to connect to the database
RUN apt-get install -y mariadb-client

# Download WP-CLI from GitHub and make it executable
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

# Create a directory to install WordPress
RUN mkdir -p /var/www/html/wordpress

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Copy the entrypoint script to the tmp directory
COPY tools/entrypoint.sh /tmp

# Copy the php-fpm configuration file to the container
COPY tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Install dumb-init, a simple process supervisor and init system
RUN apt-get install -y dumb-init

# Set dumb-init as the entrypoint and run the entrypoint script in the container
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "/tmp/entrypoint.sh"]
