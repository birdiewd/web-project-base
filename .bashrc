#!/bin/bash

. ~/.bash_aliases;

export TERM=cygwin

# export COLOR_NC='\e[0m' # No Color
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

gitHasPendingCommits () {
	if [ $(git log origin/$(gitBranch)..HEAD | grep "^Author:" | wc -l) -gt 0 ]; then 
		echo " ↑$(git log origin/$(gitBranch)..HEAD | grep "^Author:" | wc -l)";
	fi
}

gitHasChanges () {

	git status --short | wc -l | sed 's/^0.*//'' 

	if [ $(git status --short | wc -l) -ne 0 ]; then
		echo -n " *";
	fi
}

gitBranch () {
	git branch | grep "\*" | cut -d ' ' -f2-;
}

gitWrapped () {
	if [ -d .git ]; then
		printf "("
		printf "\e[0;36m$(gitBranch)\e[m"
		printf "\e[0;31m$(gitHasChanges)\e[m"
		printf "\e[1;32m$(gitHasPendingCommits)\e[m"
		printf ")"
	fi
}

PS1=""
# username
# PS1="$PS1\[\e[0;30;43m\] \u \[\e[m\] "
# current directory
PS1="$PS1\[\e[35m\]\w \[\e[m\]"
# git
PS1="$PS1\$(gitWrapped)"
#  prompt
PS1="$PS1\[\e[33m\] ⌦  \[\e[m\]"

export PS1