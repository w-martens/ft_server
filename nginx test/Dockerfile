FROM debian:buster

# update software packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# add sudo and add user
# RUN apt-get -y install sudo
# RUN sudo gpasswd -a www-data sudo
# RUN usermod -aG sudo www-data
# COPY /srcs/sudoers /etc/sudoers

#install NginX
RUN apt-get -y install nginx

#set SSL
RUN openssl req -x509 -nodes -days 365 -subj \
"/C=NL/ST=Noord-Holland/L=Amsterdam/O=wmartens/OU=coolman/CN=localhost" \
-newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key \
-out /etc/ssl/nginx-selfsigned.crt;


#copy nginx conf
COPY ./srcs/nginx.conf /etc/nginx/nginx.conf
# RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# #install mariaDB
# RUN apt-get -y install mariadb-server

# #install php
# RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
# php-zip php7.3-curl php7.3-json php7.3-mbstring php7.3-xml php7.3-zip php7.3-gd \
# php7.3-soap php7.3-ssh2 php7.3-tokenizer

# #install phpmyadmin
# WORKDIR /var/www/html/
# RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
# RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
# RUN mv phpMyAdmin-5.0.1-english phpmyadmin

# #copy phpmyadmin config
# COPY ./srcs/config.inc.php phpmyadmin

# # create tables
# COPY ./srcs/configuration.sql /var/configuration.sql
# RUN service mysql start && \
#     mysql -u root mysql < /var/www/html/phpmyadmin/sql/create_tables.sql && mysql -u root mysql < /var/configuration.sql

# # # install wordpress cli
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN php wp-cli.phar --info
# RUN chmod +x wp-cli.phar
# RUN mv wp-cli.phar /usr/local/bin/wp

# # # install & config wordpress
# RUN mkdir /var/www/html/wordpress/
# RUN chown -R www-data:www-data /var/www/
# RUN sudo -u www-data wp core download --path='/var/www/html/wordpress/'
# COPY ./srcs/wp-config.php /var/www/html
# RUN service mysql start && sudo -u www-data wp core install --url=https://localhost/wordpress --title=WP-CLI --admin_user="root" --admin_password="" --admin_email=info@example.com --path='/var/www/html/wordpress'

# # change authorization
# RUN chown -R www-data:www-data *
# RUN chmod -R 755 /var/www/*

# WORKDIR /

# # autoindex script
# COPY ./srcs/autoindex.sh ./
# RUN chmod +x autoindex.sh
# RUN echo 'alias autoindex="./autoindex.sh"' >> ~/.bashrc


#expose ports
EXPOSE 80 443

#init bash
CMD ["nginx", "-c", "/etc/nginx/nginx.conf" ]
