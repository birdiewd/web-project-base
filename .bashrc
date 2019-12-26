#!/bin/bash

export TERM=cygwin

alias lls="ls -al"
alias rc="cat ~/.bashrc"
alias rcedit="code ~/.bashrc"
alias resource="source ~/.bashrc"
alias up="./_up.sh"
alias down="./_down.sh"
alias shell="./_shell.sh"
alias www="cd /c/www"

export TERM=cygwin

gitHasChanges () {
	hasChanges=$(git status --short | wc -l)

	if [ $hasChanges -ne 0 ]; then
		echo -n " *";
	else
		echo "";
	fi

}

getGit () {
	if [ -d .git ]; then
		gitOut=$(git branch | grep "\*" | cut -d ' ' -f2-);
		hasChanges=$(gitHasChanges)
		echo -n " ($gitOut$hasChanges)"
	fi
}

PS1=""
# username
# PS1="$PS1\[\e[0;30;43m\] \u \[\e[m\] "
# current directory
PS1="$PS1\[\e[35m\]\w \[\e[m\]"
# git
PS1="$PS1\[\033[0;36m\]\$(getGit)\[\e[m\]"
#  prompt
PS1="$PS1\[\e[33m\] ⌦  \[\e[m\]"

export PS1
