FROM mysql:8

RUN apt-get clean all && \
	apt-get -y update && \
	apt-get -y install zip unzip curl && apt-get autoremove

WORKDIR /db

ADD . .
COPY . .

RUN /db/set_bash_prompt.sh

COPY create_mysql_admin_user.sh /docker-entrypoint-initdb.d/

COPY my.cnf /etc/mysql/conf.d/
