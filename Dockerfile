VOLUME ["/var/moodledata"]
EXPOSE 80 443

ENV MOODLE_URL http://127.0.0.1
    MOODLE_PASSWORD: password
    MOODLE_USERNAME: user
    MARIADB_USER: root
    MARIADB_PASSWORD: password
    MARIADB_HOST: mariadb

# Basic requirments
RUN apt-get update

#Mysql
RUN apt-get -y install mariadb mariadb-server MySQL-python70w mysql-server mysql-client pwgen python-setuptools curl git unzip

#Moodle
RUN apt-get install php70w apache2 php5 php4-qd libapache2-mod wget supervisor php5-pgsql vim curl libcurl3 

#GIT
RUN cd /tmp && \
    git clone -b MOODLE_34_STABLE git://git.moodle.org/moodle.git

#Moving folders
RUN mv /tmp/moodle/* /var/www/html && \
    chown -R www-data:www-data /var/www/html &&\
    chmod 777 /var/moodledata
