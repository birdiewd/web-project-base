FROM node:lts-alpine

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

RUN yarn global add npm-check-updates --silent && ncu -u

ENTRYPOINT ["/bin/sh", "/usr/app/run.sh"]
CMD [${API_ENV}]