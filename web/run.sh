#!/usr/bin/env sh
set -eo pipefail

# init
yarn;

case $1 in
	local)
		# nps
		tail -f ready.txt
		;;
	stage|dev|production)
		nps "$1"
		;;
esac