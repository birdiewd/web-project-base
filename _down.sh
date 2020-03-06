#!/usr/bin/env bash
set -eo pipefail

currentDirectory=$(pwd | sed 's/^.*\///g')

hasWeb=$(grep -c '^web$' .ihas || true);
hasApi=$(grep -c '^api$' .ihas || true);
hasDb=$(grep -c '^db$' .ihas || true);

dockerIncludes="-f docker-compose.yml";

if [ "$hasWeb" -eq 1 ]; then
	dockerIncludes="$dockerIncludes -f docker-compose.web.yml";
fi

if [ "$hasApi" -eq 1 ]; then
	dockerIncludes="$dockerIncludes -f docker-compose.api.yml";
fi

if [ "$hasDb" -eq 1 ]; then
	dockerIncludes="$dockerIncludes -f docker-compose.db.yml";
fi

case $1 in
	web|api|db|_status)
		docker-compose stop "$1"
		docker-compose rm -f -s "$1"
		docker rmi "$currentDirectory"_"$1" --force
		;;
    *)
		docker-compose $dockerIncludes down
		docker rmi "$currentDirectory"_api "$currentDirectory"_db "$currentDirectory"_web --force
		;;
esac
