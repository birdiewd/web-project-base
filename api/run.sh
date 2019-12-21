#!/usr/bin/env sh
set -eo pipefail

case $3 in
	local)
		# node /usr/app/server.js
		tail -f ready.txt
		;;
	stage|dev|production)
		tail -f ready.txt
		;;
	*)
		echo "$1 | $2 | $3"
esac