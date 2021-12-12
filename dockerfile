FROM php:7.2-apache
RUN apt-get update && \
	apt-get install -y
RUN apt-get install -y curl
RUN apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev
RUN apt-get install -y libicu-dev
COPY elioter.conf /etc/apache2/sites-enabled/elioter.conf
RUN apt-get update
RUN docker-php-ext-install intl
RUN docker-php-ext-configure intl
RUN docker-php-ext-install mysqli pdo pdo_mysql zip mbstring
RUN a2enmod rewrite
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd
COPY . /var/www/html/
RUN chmod -v 777 application/config/config.php
RUN chmod -v 777 application/config/database.php
RUN chmod -v 777 temp
RUN service apache2 restart