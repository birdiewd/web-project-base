#!/usr/bin/env bash
set -eo pipefail

case $1 in
	web|api|db)
		docker-compose up --remove-orphans --build $1
		;;
    *)
		docker-compose up --remove-orphans --build
		;;
esac
