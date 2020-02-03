#!/usr/bin/env sh
set -eo pipefail

showHelp() {
	echo "Set the environment for a docker service."
	echo ""
	echo "	Services:	web, api (required)"
	echo "	Environments:	alpha, local (default: local)"
	echo ""
	echo "USAGE:"
	echo "	./_upgrade.sh (web|api) (alpha|local)"
	echo ""
}

case $2 in
	local)
		env="local"
		;;
	*)
		env="alpha"
		;;
esac

case $1 in
	web)
		sed -i 's/^WEB_ENV=.*/WEB_ENV='$env'/' .env
		cp .env web/.env
		cp .env api/.env
		;;
	api)
		sed -i 's/^API_ENV=.*/API_ENV='$env'/' .env
		cp .env web/.env
		cp .env api/.env
		;;
	-h|--help)
		echo ""
		showHelp
		;;
	*)
		echo ""
		echo "No service provided!"
		echo ""
		showHelp
		;;
esac

cat .env