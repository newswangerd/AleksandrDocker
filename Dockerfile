FROM php:7.0-apache
EXPOSE 80 443  
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
#RUN git clone -b MOODLE_33_STABLE git://git.moodle.org/moodle.git --depth=1 /var/www/moodle
RUN    chmod  -R 777 /var/www 
COPY moodle /var/www/html
