#!/usr/bin/env sh
set -eo pipefail

yarn;

case $1 in
	local)
		node /usr/app/server.js
		tail -f ready.txt
		;;
	stage|dev|production)
		tail -f ready.txt
		;;
esac