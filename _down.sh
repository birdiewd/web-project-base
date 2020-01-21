#!/usr/bin/env bash
set -eo pipefail

currentDirectory=$(pwd | sed 's/^.*\///g')

case $1 in
	web|api|db|_status)
		docker-compose stop "$1"
		docker-compose rm -f -s "$1"
		docker rmi "$currentDirectory"_"$1" --force
		;;
    *)
		docker-compose down
		docker rmi "$currentDirectory"_api "$currentDirectory"_db "$currentDirectory"_web --force
		;;
esac
