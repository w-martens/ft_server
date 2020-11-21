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
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Global Security/OU=IT Department/CN=localhost"
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
COPY ./srcs/nginx.conf /etc/nginx/sites-available/nginxconf
COPY ./srcs/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ./srcs/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
RUN ln -s /etc/nginx/sites-available/nginxconf /etc/nginx/sites-enabled/ && nginx -t
COPY ./srcs/config.inc.php phpmyadmin
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.\
tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.t\
ar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php /var/www/html/wordpress
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
WORKDIR /
# install wordpress cli 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./srcs/init.sh /init.sh
CMD bash init.sh
