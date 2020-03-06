FROM node:lts-alpine

ARG WEB_ENV=production

WORKDIR /usr/app

ADD . .
COPY . .

ENV NPM_CONFIG_LOGLEVEL warn

RUN apk update && apk -U --no-cache --allow-untrusted add \
	bash \
	yarn \
	coreutils

RUN ./set_bash_prompt.sh

RUN yarn global add npm-check-updates nps why-npm-i-so-long parcel --silent

ENTRYPOINT ["/bin/bash", "/usr/app/run.sh"]

# alpha|local|dev|stage|production
CMD ${WEB_ENV}