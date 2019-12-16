#!/usr/bin/env bash


# if .env is missing, build .env and .iam

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

cp .env web/.env
cp .env api/.env
cp .env db/.env

rm .env

{
	printf "$projectName"
} > .iam

cp .iam web/.iam
cp .iam api/.iam
cp .iam db/.iam

rm .iam

docker-compose up --remove-orphans --build
