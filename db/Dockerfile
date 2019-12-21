FROM mysql:8

RUN apt-get clean all
RUN apt-get -y update

# === === === === === === ===
# stretch to buster upgrade
# === === === === === === ===
# RUN apt-get -y upgrade
# RUN apt-get -y full-upgrade
# RUN apt-get -y --purge autoremove
# RUN sed -i 's/stretch/buster/g' /etc/apt/sources.list
# RUN apt-get -y update
# RUN apt-get -y upgrade
# RUN apt-get -y full-upgrade

RUN apt-get -y install zip unzip
RUN apt-get -y install curl 
RUN apt-get autoremove

WORKDIR /db

ADD . .
COPY . .

RUN /db/set_bash_prompt.sh

COPY create_mysql_admin_user.sh /docker-entrypoint-initdb.d/

COPY my.cnf /etc/mysql/conf.d/
