
FROM php:7.0-apache

#VOLUME ["/var/moodledata"]
#EXPOSE 80 443

ENV MOODLE_VERSION=32 \
    MOODLE_GITHUB=git://git.moodle.org/moodle.git \
    MOODLE_DESTINATION=/var/www/html

# Basic requirments 
# Do Postgresql
RUN apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
                          graphviz aspell libpspell-dev git-core \
    && apt-get install -y libicu-dev libxml2-dev libcurl4-openssl-dev \
                          libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install intl pdo xmlrpc curl pspell ldap zip pgsql gd opcache soap \
    && docker-php-ext-enable opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*

#Attempt the impossible - download php7
#RUN wget -q http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
#    wget -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
#    rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm && \
#    yum-config-manager --enable remi-php70 && \
#    yum -y install php && \
#    yum -y install php-xml
#RUN apt-get -y install initscripts

RUN git clone -b MOODLE_${MOODLE_VERSION}_STABLE --depth 1 ${MOODLE_GITHUB} ${MOODLE_DESTINATION}

RUN mkdir -p /moodle/data && \
    chown -R www-data:www-data /moodle && \
    chmod 2775 /moodle && \
    ln -sf /moodle/conf/config.php ${MOODLE_DESTINATION}/config.php

#RUN chown -R 777 /var/moodledata && \
RUN    chmod 777 /var/www 
   # chmod -R 755 /var/lib
# Enable mod_rewrite
RUN a2enmod rewrite
#CMD ["httpd", "-DFOREGROUND"]

