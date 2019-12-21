#!/usr/bin/env sh
set -eo pipefail

case $1 in
	web|api|db|allup)
        docker-compose exec $1 bash
		;;
    *)
        echo "no service provided (web/api/db)"
esac