#!/usr/bin/env bash
set -eo pipefail

# Start Color Code: \[\033[

# WEIGHT
# Normal: 0;
# Bold: 1;

# FOREGROUND
# Black: 30
# Blue: 34
# Cyan: 36
# Green: 32
# Purple: 35
# Red: 31
# White: 37
# Yellow: 33

# BACKGROUND
# Black background: 40
# Blue background: 44
# Cyan background: 46
# Green background: 42
# Purple background: 45
# Red background: 41
# White background: 47
# Yellow background: 43

# End Color Code: m\]

# Reset: 00 || \[\e[m\]

build-or-start () {
	case $1 in 
		api|web|db|allup)
			if docker-compose ps | grep -q "$1""_1\s"
			then
				# echo "$1 built";
				docker-compose start "$1";
			else
				# echo "$1 not built";
				docker-compose up -d --remove-orphans --build "$1";
			fi
		;;
	*)
		echo "Nothing to build"
		;;
	esac;
}

env () {
	if [ ! -f .env ]; then
		portNumberDefault=3000
		projectNameDefault=$(pwd | sed 's/^.*\///g' | sed 's/[-_]/ /g')

		echo "";

		read -p "Web Port ($portNumberDefault): " portNumber
		portNumber=${portNumber:-$portNumberDefault}

		read -p "Project Name ($projectNameDefault): " projectName
		projectName=${projectName:-$projectNameDefault}

		{
			echo "WEB_PORT=$portNumber"
			echo "WEB_HMR_PORT=$((30000 + portNumber))"
			echo "API_PORT=$((40000 + portNumber))"
			echo "DB_PORT=$((50000 + portNumber))"
			echo "PROJECT_NAME=$projectName"
		} > .env

		{
			printf "%s" "$projectName"
		} > .iam
	fi
}

web () {
	env;
	cp .env web/.env
	echo "WEB_ENV=alpha" >> web/.env
	cp .iam web/.iam
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
