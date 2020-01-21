FROM node:lts-alpine

WORKDIR /usr/app

RUN mkdir /usr/app/.cache
RUN mkdir /usr/app/logs
RUN mkdir /usr/app/node_modules

RUN apk update
RUN apk -U --no-cache --allow-untrusted add \
	bash \
	yarn \
	curl \
	mysql-client

ADD . .
COPY . .

ENV NPM_CONFIG_LOGLEVEL silent

ENTRYPOINT ["/bin/sh", "/usr/app/run.sh"]