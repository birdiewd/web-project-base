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

getGit () {
	if [ -d .git ]; then
		gitOut=$(git branch | grep "\*" | cut -d ' ' -f2-);
		echo " ($gitOut)"
	fi
}

# export PS1export PATH=$PATH:$HOME/.git-radar

# PS1="\[\033[36m\]\u\[\033[46m\]\[\033[30m\]\[\033[0m\]: \[\033[1;34m\]\w \[\033[0;33m\]\$ \[\033[0m\]"

PS1="\[\e[0;30;47m\] \u \[\e[m\]\[\e[35m\] \w\[\e[m\]"

PS1="$PS1\[\033[0;36m\]\$(getGit)\[\e[m\]"

PS1="$PS1\[\e[33m\] ⌦ \[\e[m\]"

export PS1