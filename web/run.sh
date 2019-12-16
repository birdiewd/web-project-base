#!/usr/bin/env sh
set -eo pipefail

# init
# yarn;

case $1 in
	alpha)
		tail -f ready.txt
		;;
	local)
		nps | cat
		;;
	stage|dev|production)
		nps "$1"
		;;
esac