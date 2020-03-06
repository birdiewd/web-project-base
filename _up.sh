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

		read -e -p "Use WEB container (Y/n): " hasWEB
		hasWEB=$(makeBool "${hasWEB:-y}")

		read -e -p "Use API container (Y/n): " hasAPI
		hasAPI=$(makeBool "${hasAPI:-y}")

		read -e -p "Use DB container (Y/n): " hasDB
		hasDB=$(makeBool "${hasDB:-y}")

		if [ "$hasWEB" -eq 1 ]; then
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
		if [ "$hasAPI" -eq 1 ]; then
			read -e -p "API Port ($apiPortNumberDefault): " -i "$apiPortNumberDefault" apiPortNumber
			apiPortNumber=${apiPortNumber:-$apiPortNumberDefault}
		else
			apiPortNumber=$apiPortNumberDefault
		fi

		dbPortNumberDefault=$((webPortNumber+50000))
		if [ "$hasDB" -eq 1 ]; then
			read -e -p "DB Port ($dbPortNumberDefault): " -i "$dbPortNumberDefault" dbPortNumber
			dbPortNumber=${dbPortNumber:-$dbPortNumberDefault}
		else
			dbPortNumber=$dbPortNumberDefault
		fi

		statusPortNumberDefault=$((webPortNumber+60000))
		read -e -p "Status Port ($statusPortNumberDefault): " -i "$statusPortNumberDefault" statusPortNumber
		statusPortNumber=${statusPortNumber:-$statusPortNumberDefault}

		read -e -p "Project Name ($projectNameDefault): " -i "$projectNameDefault" projectName
		projectName=${projectName:-$projectNameDefault}

		{
			if [ "$hasWEB" -eq 1 ]; then echo "web"; else printf ""; fi
			if [ "$hasAPI" -eq 1 ]; then echo "api"; else printf ""; fi
			if [ "$hasDB" -eq 1 ]; then echo "db"; else printf ""; fi
		} > .ihas

		while [ ! -f .ihas ]; do sleep 1; done

		{
			# web service
			echo "WEB_PORT=$webPortNumber"
			echo "WEB_HMR_PORT=$webHmrPortNumber"
			echo "WEB_ENV=alpha"
			# api service
			echo "API_PORT=$apiPortNumber"
			echo "API_ENV=alpha"
			# db service
			echo "DB_PORT=$dbPortNumber"
			# db service
			echo "STATUS_PORT=$statusPortNumber"
			# project name
			echo "PROJECT_NAME=$projectName"
			# project services
			echo "I_HAS=$(sed -z 's/\n/,/g;s/,$//g' < .ihas)"
		} > .env

		{
			printf "%s" "$projectName"
		} > .iam
	fi
}

# build-or-start () {
# 	case $1 in 
# 		api|web|db|_status)
# 			if docker-compose ps | grep -q "$1""_1\s"
# 			then
# 				docker-compose start "$1";
# 			else
# 				docker-compose \
# 				-f docker-compose.yml \
# 				-f "docker-compose.$1.yml" \
# 				up \
# 				-d --remove-orphans "$1";
# 			fi
# 		;;
# 	*)
# 		echo "Nothing to build"
# 		;;
# 	esac;
# }

# web () {
# 	env;
# 	cp .env web/.env
# 	cp .iam web/.iam
# 	build-or-start web;
# }

# api () {
# 	env;
# 	cp .env api/.env
# 	cp .iam api/.iam
# 	build-or-start api;
# }

# db () {
# 	env;
# 	cp .env db/.env
# 	cp .iam db/.iam
# 	build-or-start db;
# }

# _status () {
# 	env;
# 	cp .env _status/.env
# 	cp .iam _status/.iam
# 	cp .ihas _status/.ihas

# 	docker-compose up --remove-orphans _status
# }

all () {
	env;

	dockerIncludes="-f docker-compose.yml";

	hasWeb=$(grep -c '^web$' .ihas || true);
	hasApi=$(grep -c '^api$' .ihas || true);
	hasDb=$(grep -c '^db$' .ihas || true);

	if [ "$hasWeb" -eq 1 ]; then
		dockerIncludes="$dockerIncludes -f docker-compose.web.yml";
	fi

	if [ "$hasApi" -eq 1 ]; then
		dockerIncludes="$dockerIncludes -f docker-compose.api.yml";
	fi

	if [ "$hasDb" -eq 1 ]; then
		dockerIncludes="$dockerIncludes -f docker-compose.db.yml";
	fi

	docker-compose $dockerIncludes up -d --remove-orphans;
}

case $1 in
	# web)
	# 	web
	# 	;;
	# api)
	# 	api
	# 	;;
	# db)
	# 	db
	# 	;;

	# _status)
	# 	_status
	# 	;;
	clean)
		rm .env -f
		rm .iam -f
		rm .ihas -f
		all
		;;
	*)
		all
		;;
esac
