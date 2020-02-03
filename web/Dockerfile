FROM node:lts-alpine

ARG WEB_ENV=production

WORKDIR /usr/app

RUN mkdir /usr/app/.cache
RUN mkdir /usr/app/logs
RUN mkdir /usr/app/node_modules

ADD . .
COPY . .

ENV NPM_CONFIG_LOGLEVEL warn

RUN apk update
RUN apk -U --no-cache --allow-untrusted add \
	bash \
	yarn \
	coreutils

RUN ./set_bash_prompt.sh

RUN yarn global add npm-check-updates nps why-npm-i-so-long parcel --silent
RUN ncu && ncu -u

ENTRYPOINT ["/bin/bash", "/usr/app/run.sh"]

# alpha|local|dev|stage|production
CMD ${WEB_ENV}