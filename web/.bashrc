#!/bin/bash

# =======
# aliases
# =======

alias lls="ls -al";
alias resource="source ~/.bashrc";

# ==========================================

# export COLOR_NC='\e[0;0;0m' # No Color
# export COLOR_WHITE='\e[1;37m'
# export COLOR_BLACK='\e[0;30m'
# export COLOR_BLUE='\e[0;34m'
# export COLOR_LIGHT_BLUE='\e[1;34m'
# export COLOR_GREEN='\e[0;32m'
# export COLOR_LIGHT_GREEN='\e[1;32m'
# export COLOR_CYAN='\e[0;36m'
# export COLOR_LIGHT_CYAN='\e[1;36m'
# export COLOR_RED='\e[0;31m'
# export COLOR_LIGHT_RED='\e[1;31m'
# export COLOR_PURPLE='\e[0;35m'
# export COLOR_LIGHT_PURPLE='\e[1;35m'
# export COLOR_BROWN='\e[0;33m'
# export COLOR_YELLOW='\e[1;33m'
# export COLOR_GRAY='\e[0;30m'
# export COLOR_LIGHT_GRAY='\e[0;37m'

PROJECT_NAME=$(cat .iam)
CONTAINER_TYPE=web
ON_ICON="0"
OFF_ICON="."

DB_COLOR="1;31;40"
API_COLOR="1;33;40"
WEB_COLOR="1;32;40"

case $CONTAINER_TYPE in

		db)
			DEFAULT_COLOR="$DB_COLOR"
		;;

		api)
			DEFAULT_COLOR="$API_COLOR"
		;;

		web)
			DEFAULT_COLOR="$WEB_COLOR"
		;;

		*)
			DEFAULT_COLOR="0;0"
	
	esac

bashInfo () {
	printf "\e[%sm%s\e[0m" "$DEFAULT_COLOR"  "╓ "

	printf "\e[%sm%s\e[0m" "$DEFAULT_COLOR" " $CONTAINER_TYPE "

	case $CONTAINER_TYPE in

		db)
			# printf "\e[%sm%s\e[0;0m" "$DEFAULT_COLOR" "$ON_ICON"
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
		;;

		api)
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
			# printf "\e[%sm%s\e[0;0m" "$DEFAULT_COLOR" "$ON_ICON"
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
		;;

		web)
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
			# printf "\e[%sm%s\e[0;0m" "$DEFAULT_COLOR" "$ON_ICON"
		;;

		*)
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
			# printf "\e[%sm%s\e[0;0m" "0;0" "$OFF_ICON"
		;;
	
	esac

	printf "\e[0;30;47m%s\e[0m" " $PROJECT_NAME "

	printf "\e[1;30m%s\e[0m" " "
	printf "\e[0;35m%s\e[0m" "$PWD "
}

bashPrompt () {
	echo 
	printf "\e[%sm%s\e[0;0;0m" "$DEFAULT_COLOR" "╙› "
}

PS1=""
# current directory
PS1="$PS1\$(bashInfo)"
# git
# PS1="$PS1\$(gitInfo)"
#  prompt
PS1="$PS1\$(bashPrompt)"

export PS1