#!/usr/bin/env bash
set -eo pipefail

env () {
	if [ ! -f .env ]; then
		portNumberDefault=3000
		projectNameDefault=`pwd | sed 's/^.*\///g' | sed 's/[-_]/ /g'`

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
			printf "$projectName"
		} > .iam
	fi
}

web () {
	env;
	cp .env web/.env
	echo "APP_ENV=alpha" >> web/.env
	cp .iam web/.iam
}

api () {
	env;
	cp .env api/.env
	cp .iam api/.iam
	echo "APP_ENV=alpha" >> api/.env
}

db () {
	env;
	cp .env db/.env
	cp .iam db/.iam
}

allup () {
	env;
	cp .env allup/.env
	cp .iam allup/.iam
}

all () {
	env;
	web;
	api;
	db;
	allup;
	docker-compose up --remove-orphans --build
}

case $1 in
	web)
		web
		docker-compose up --remove-orphans --build "$1"
		;;
	api)
		api
		docker-compose up --remove-orphans --build "$1"
		;;
	db)
		db
		docker-compose up --remove-orphans --build "$1"
		;;
	allup)
		allup
		docker-compose up --remove-orphans --build "$1"
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
