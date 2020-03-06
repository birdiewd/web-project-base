FROM node:lts-alpine

WORKDIR /usr/app

RUN apk update && apk -U --no-cache --allow-untrusted add \
	bash \
	yarn \
	curl \
	mysql-client

ADD . .
COPY . .

ENV NPM_CONFIG_LOGLEVEL silent

ENTRYPOINT ["/bin/sh", "/usr/app/run.sh"]