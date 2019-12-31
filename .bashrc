#!/bin/bash

# shellcheck source=/dev/null
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
	git rev-list --right-only --count origin/"$(gitBranch)"..HEAD | sed -e 's/^0.*//; s/^\([0-9]\+\)/ ↑\1/'
	return 0;
}

gitHasStash () {
	git stash list 2>/dev/null | wc -l | sed -e 's/^0.*//; s/^\([0-9]\+\)/ ∫\1/'
	return 0;
}

gitHasChanges () {
	git status --short 2>/dev/null | wc -l | sed -e 's/^0.*//;s/\([0-9]\+\)/ Δ\1/'
	return 0;
}

gitBranch () {
	git symbolic-ref --short HEAD 2>/dev/null
	return 0;
}

gitInfo () {
	if [ -d .git ]; then
		printf "\e[1;30m%s\e[0m" "("
		printf "\e[0;36m%s\e[0m" "$(gitBranch)"
		printf "\e[1;31m%s\e[0m" "$(gitHasChanges)"
		printf "\e[1;32m%s\e[0m" "$(gitHasPendingCommits)"
		printf "\e[0;33m%s\e[0m" "$(gitHasStash)"
		printf "\e[1;30m%s\e[0m" ")"
	fi
	return 0;
}

bashInfo () {
	printf "\e[1;35m%s\e[0m" "╓  "
	printf "\e[0;35m%s\e[0m" "$PWD "
}

bashPrompt () {
	echo 
	printf "\e[1;35m%s\e[0m" "╙› "
}

PS1=""
# current directory
PS1="$PS1\$(bashInfo)"
# git
PS1="$PS1\$(gitInfo)"
#  prompt
PS1="$PS1\$(bashPrompt)"

export PS1