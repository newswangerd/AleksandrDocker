#specify the version of centos
FROM centos:7

VOLUME ["/var/moodledata"]
EXPOSE 80 443

ENV MOODLE_URL http://127.0.0.1 \
    MOODLE_PASSWORD="password" \
    MOODLE_USERNAME="user" \
    MARIADB_USER="root" \
    MARIADB_PASSWORD="password" \
    MARIADB_HOST="mariadb"

# Basic requirments 
RUN  yum -y install mariadb mariadb-server MySQL-python70w git curl unzip wget

#Attempt the impossible - download php7
RUN wget -q http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    wget -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm && \
    yum-config-manager --enable remi-php70 && \
    yum -y install php

#Moodle
#GIT
COPY  moodle/ /tmp/moodle
# OR THIS CAN WORK TOO
# COPY moodle/ /var/www/html
# in case if it fails
RUN git clone -b MOODLE_33_STABLE git://git.moodle.org/moodle.git --depth=1 /var/www/moodle
WORKDIR /var/www/moodle

CMD ["httpd", "-DFOREGROUND"]

# TO CHECK IT OUT - > copy files to the /var/www/html
COPY moodle /var/www/html
#Moving folders
#RUN mv /tmp/moodle/* /var/www/html && \
#    chown -R www-data:www-data /var/www/html &&\
#    chmod 777 /var/moodledata
