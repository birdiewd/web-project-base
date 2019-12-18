FROM node:lts-alpine

WORKDIR /usr/app

COPY . .

ENV NPM_CONFIG_LOGLEVEL warn

ENTRYPOINT ["/bin/sh", "./print_env.sh"]