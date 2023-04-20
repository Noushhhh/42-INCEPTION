# Change directory to the WordPress root directory
cd /var/www/html/wordpress

# Download WordPress core files to the specified directory
wp core download --path=/var/www/html/wordpress --allow-root

# Generate the wp-config.php file and configure it with the specified database name, username, password, host, and table prefix
wp config create --path=/var/www/html/wordpress --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_

# Install WordPress core files with the specified site URL, site title, administrator username, password, and email address
wp core install --path=/var/www/html/wordpress --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

# Create a user with the specified username, email address, and password
wp plugin update --allow-root --all
wp user create --path=/var/www/html/wordpress --allow-root $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD

# Set permissions for the uploads directory to the web server user (www-data)
chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R

# Launch PHP-FPM by creating a directory for the PHP-FPM socket and running the PHP-FPM process in foreground mode
mkdir -p /run/php/
php-fpm7.3 -F