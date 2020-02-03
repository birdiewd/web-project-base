#!/usr/bin/env sh
set -eo pipefail

touch ready.txt
echo "" > ready.txt

yarn;

for lastArg; do :; done

case $lastArg in
	alpha)
		echo "SERVICE IS UP BUT SERVER IS NOT RUNNING"
		tail -f ready.txt
		;;
	local)
		node /usr/app/server.js
		tail -f ready.txt
		;;
	# stage|dev|production)
	# 	tail -f ready.txt
	# 	;;
	*)
		echo "========="
		echo "$lastArg"
		echo "========="
		tail -f ready.txt
		;;
esac