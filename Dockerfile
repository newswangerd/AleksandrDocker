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
    
#RUN     yum -y install deltarpm && \
#	yum -y install epel-release && \
#	rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi && \
#	rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
#	yum-config-manager --enable extras && \
#	yum-config-manager --enable epel && \
#	yum-config-manager --enable remi && \
#	yum-config-manager --disable remi-php55 && \
#	yum-config-manager --disable remi-php56 && \
#	#yum-config-manager --disable remi-php70 && \
#	yum-config-manager --enable remi-php71 && \
#	rpm -ivh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm 
#GIT
#COPY  /tmp /tmp/moodle
RUN git clone -b MOODLE_33_STABLE git://git.moodle.org/moodle.git --depth=1 /var/www/moodle
WORKDIR /var/www/moodle

#Moving folders
#RUN mv /tmp/moodle/* /var/www/html && \
#    chown -R www-data:www-data /var/www/html &&\
#    chmod 777 /var/moodledata
