#!/usr/bin/env sh
set -eo pipefail

case $1 in
	web|api|db|_status)
		docker-compose exec "$1" env TERM=xterm-256color bash
		;;
	*)
		echo ""
		echo "no service provided (web/api/db)"
		echo ""
esac