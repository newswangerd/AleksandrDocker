FROM centos

VOLUME ["/var/moodledata"]
EXPOSE 80 443

ENV MOODLE_URL http://127.0.0.1 \
    MOODLE_PASSWORD="password" \
    MOODLE_USERNAME="user" \
    MARIADB_USER="root" \
    MARIADB_PASSWORD="password" \
    MARIADB_HOST="mariadb"

# Basic requirments
RUN  yum -y install mariadb mariadb-server MySQL-python70w mysql-server mysql-client pwgen python-setuptools curl git unzip && \
#Moodle
     yum install php70w apache2 php5 php4-qd libapache2-mod wget supervisor php5-pgsql vim curl libcurl3  && \

#GIT
     cd /tmp && \
     cp /moodle /tmp

#Moving folders
#RUN mv /tmp/moodle/* /var/www/html && \
#    chown -R www-data:www-data /var/www/html &&\
#    chmod 777 /var/moodledata
