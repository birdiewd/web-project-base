#!/usr/bin/env bash
set -eo pipefail

env () {
	if [ ! -f .env ]; then
		portNumberDefault=3000
		projectNameDefault=`pwd | sed 's/^.*\///g' | sed 's/[-_]/ /g'`

		read -p "Web Port ($portNumberDefault): " portNumber
		portNumber=${portNumber:-$portNumberDefault}

		read -p "Project Name ($projectNameDefault): " projectName
		projectName=${projectName:-$projectNameDefault}

		{
			echo "WEB_PORT=$portNumber"
			echo "WEB_HMR_PORT=$((30000 + portNumber))"
			echo "DB_PORT=$((40000 + portNumber))"
			echo "API_PORT=$((50000 + portNumber))"
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
	cp .iam web/.iam
}

api () {
	env;
	cp .env api/.env
	cp .iam api/.iam
}

db () {
	env;
	cp .env db/.env
	cp .iam db/.iam
}

allup () {
	env;
	cp .env done/.env
	cp .iam done/.iam
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
		docker-compose up --remove-orphans --build $1
		;;
	api)
		api
		docker-compose up --remove-orphans --build $1
		;;
	db)
		db
		docker-compose up --remove-orphans --build $1
		;;
	clean)
		rm .env 2> /dev/null
		rm .iam 2> /dev/null
		all
		;;
    *)
		all
		;;
esac
