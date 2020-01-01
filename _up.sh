#!/usr/bin/env bash
set -eo pipefail

makeBool () {
	if [[ "$1" = 'y' ]] || [[ "$1" = 'Y' ]]; then
		echo 1;
	else
		echo 0;
	fi;
}

env () {
	if [ ! -f .env ]; then
		webPortNumberDefault=3000
		projectNameDefault=$(pwd | sed 's/^.*\///g' | sed 's/[-_]/ /g')

		echo "";

		read -e -p "Use WEB container (Y/n): " -i "y" hasWEB
		hasWEB=$(makeBool ${hasWEB:-y})

		read -e -p "Use API container (Y/n): " -i "y" hasAPI
		hasAPI=$(makeBool ${hasAPI:-y})

		read -e -p "Use DB container (Y/n): " -i "y" hasDB
		hasDB=$(makeBool ${hasDB:-y})

		if [ $hasWEB -eq 1 ]; then
			read -e -p "WEB Port ($webPortNumberDefault): " -i "$webPortNumberDefault" webPortNumber
			webPortNumber=${webPortNumber:-$webPortNumberDefault}

			webHmrPortNumberDefault=$((webPortNumber+30000))
			read -e -p "WEB HMR Port ($webHmrPortNumberDefault): " -i "$webHmrPortNumberDefault" webHmrPortNumber
			webHmrPortNumber=${webHmrPortNumber:-$webHmrPortNumberDefault}
		else
			webPortNumber=$webPortNumberDefault
			webHmrPortNumber=$((webPortNumber+30000))
		fi

		apiPortNumberDefault=$((webPortNumber+40000))
		if [ $hasAPI -eq 1 ]; then
			read -e -p "API Port ($apiPortNumberDefault): " -i "$apiPortNumberDefault" apiPortNumber
			apiPortNumber=${apiPortNumber:-$apiPortNumberDefault}
		else
			apiPortNumber=$apiPortNumberDefault
		fi

		dbPortNumberDefault=$((webPortNumber+50000))
		if [ $hasDB -eq 1 ]; then
			read -e -p "DB Port ($dbPortNumberDefault): " -i "$dbPortNumberDefault" dbPortNumber
			dbPortNumber=${dbPortNumber:-$dbPortNumberDefault}
		else
			dbPortNumber=$dbPortNumberDefault
		fi

		read -e -p "Project Name ($projectNameDefault): " -i "$projectNameDefault" projectName
		projectName=${projectName:-$projectNameDefault}

		{
			if [ $hasWEB -eq 1 ]; then echo "web"; else printf ""; fi
			if [ $hasAPI -eq 1 ]; then echo "api"; else printf ""; fi
			if [ $hasDB -eq 1 ]; then echo "db"; else printf ""; fi
		} > .ihas

		{
			if [ $hasWEB -eq 1 ]; then
				echo "WEB_PORT=$webPortNumber"
				echo "WEB_HMR_PORT=$webHmrPortNumber"
			fi

			if [ $hasAPI -eq 1 ]; then
				echo "API_PORT=$apiPortNumber"
			fi

			if [ $hasDB -eq 1 ]; then
				echo "DB_PORT=$dbPortNumber"
			fi

			echo "PROJECT_NAME=$projectName"
		} > .env

		{
			printf "%s" "$projectName"
		} > .iam

		# for i in ".env" ".iam" ".ihas"; do echo $i; cat $i; printf "\n\n"; done;
	fi
}

build-or-start () {
	case $1 in 
		api|web|db|allup)
			if docker-compose ps | grep -q "$1""_1\s"
			then
				docker-compose start "$1";
			else
				docker-compose up -d --remove-orphans --build "$1";
			fi
		;;
	*)
		echo "Nothing to build"
		;;
	esac;
}

web () {
	env;
	cp .env web/.env
	cp .iam web/.iam
	echo "WEB_ENV=alpha" >> web/.env
	build-or-start web;
}

api () {
	env;
	cp .env api/.env
	cp .iam api/.iam
	echo "API_ENV=alpha" >> api/.env
	build-or-start api;
}

db () {
	env;
	cp .env db/.env
	cp .iam db/.iam
	build-or-start db;
}

allup () {
	env;
	cp .env allup/.env
	cp .iam allup/.iam
	cp .ihas allup/.ihas
	docker-compose up --remove-orphans --build allup
}

all () {
	env;
	web;
	api;
	db;
	allup;
}

case $1 in
	web)
		web
		;;
	api)
		api
		;;
	db)
		db
		;;
	allup)
		allup
		;;
	clean)
		rm .env -f
		rm .iam -f
		all
		;;
	*)
		all
		;;
esac
