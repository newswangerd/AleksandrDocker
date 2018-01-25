VOLUME ["/var/moodledata"]
EXPOSE 80 443

ENV MOODLE_URL http://127.0.0.1
    MOODLE_PASSWORD: password
    MOODLE_USERNAME: user
    MARIADB_USER: root
    MARIADB_PASSWORD: password
    MARIADB_HOST: mariadb

RUN apt-get update && \
	apt-get -y install mysql-client python-setuptools curl git unzip apache2 php \
		mariadb mariadb-server MySQL-python php70w \
		php-gd libapache2-mod-php postfix wget php-pgsql && \
		cd /tmp && \
		git clone -b MOODLE_34_STABLE git://git.moodle.org/moodle.git 
		mv /tmp/moodle/* /var/www/html/ && \
		chown -R www-data:www-data /vaar/www/html &&\
		chmod 777 /var/moodledata
