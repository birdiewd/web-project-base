#!/usr/bin/env sh
set -eo pipefail

case $1 in
	web|api|db|_status)
        docker-compose logs -f $1
		;;
    *)
        docker-compose logs -f --tail=10
esac