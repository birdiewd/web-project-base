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
		nps
		tail -f ready.txt
		;;
	stage|dev|production)
		nps "$lastArg"
		;;
	*)
		echo "========="
		echo "$lastArg"
		echo "========="
		tail -f ready.txt
		;;
esac