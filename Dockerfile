FROM php:7.0-apache

EXPOSE 443 80

#RN docker-php-source extract \
#    && docker-php-ext-install -j$(nproc) iconv mcrypt \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#    && docker-php-ext-install -j$(nproc) gd \
#    && docker-php-ext-install mysqli pdo pdo_mysql

#RUN apt-get update && apt-get install -y mysql-client libmysqlclient-dev \ 
  
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli


#RUN git clone -b MOODLE_${MOODLE_VERSION}_STABLE --depth 1 ${MOODLE_GITHUB} ${MOODLE_DESTINATION}


RUN chown -R 777 /var/www
RUN    chmod 777 /var/www 
   # chmod -R 755 /var/lib
# Enable mod_rewrite
#RUN a2enmod rewrite
#CMD ["httpd", "-DFOREGROUND"]
