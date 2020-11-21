FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install	\
					wget	\
					nginx	\
					mariadb-server	\
					php7.3 php-mysql php-fpm php-pdo php-gd \
					php-cli php-mbstring 
COPY ./srcs/index.php /var/www/html/index.php

# make ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Global Security/OU=IT Department/CN=localhost"
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

COPY ./srcs/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ./srcs/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

RUN ln -s /etc/nginx/sites-available/nginxconf /etc/nginx/sites-enabled/ && nginx -t

WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.\
tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.t\
ar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin

# create tables
COPY ./srcs/configuration.sql /var/configuration.sql
RUN service mysql start && \
    mysql -u root mysql < /var/www/html/phpmyadmin/sql/create_tables.sql && mysql -u root mysql < /var/configuration.sql

# install wordpress cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /
#install & config wordpress
RUN wp core download --allow-root --path='/var/www/html/wordpress/'
RUN service mysql start && wp core config --allow-root --dbname="localhost" --dbuser="root" --dbpass="" --path='/var/www/html/wordpress'
RUN service mysql start && wp core install --allow-root --url=localhost --title=Localhost --admin_user="root" --admin_password="" --admin_email=info@example.com --path='/var/www/html/wordpress'
COPY ./srcs/init.sh /init.sh
RUN chown -R www-data:www-data /var/www/html/*
RUN chmod -R 755 /var/www/*
CMD bash init.sh
