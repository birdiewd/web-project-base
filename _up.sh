#!/usr/bin/env bash

portNumberDefault=80
projectNameDefault=`pwd | sed 's/^.*\///g' | sed 's/[-_]/ /g'`

read -p "Port ($portNumberDefault): " portNumber
portNumber=${portNumber:-$portNumberDefault}

read -p "Project Name ($projectNameDefault): " projectName
projectName=${projectName:-$projectNameDefault}

{
	echo "PORT=$portNumber"
	echo "HMR_PORT=$((30000 + portNumber))"
	echo "PROJECT_NAME=$projectName"
} > .env

echo "$projectName" > .iam