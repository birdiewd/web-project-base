#!/bin/bash

PROJECT_NAME=$(cat .iam)
CONTAINER_TYPE=db
ON_ICON=●
OFF_ICON=○

{
	printf "\n\n. /db/.bashrc;\n\n"
	printf "PS1=\""
	printf "\\[\\033[0;33m\\]%s\\[\\033[0;0m\\]" "$CONTAINER_TYPE "
	printf "\\[\\033[0;33m\\]%s\\[\\033[0;0m\\]" "$ON_ICON"
	printf "\\[\\033[0;32m\\]%s\\[\\033[0;0m\\]" "$OFF_ICON"
	printf "\\[\\033[1;34m\\]%s\\[\\033[0;0m\\]" "$OFF_ICON"
	printf "\\[\\033[0;36m\\]%s\\[\\033[0;0m\\]" " $PROJECT_NAME"
	printf "\\[\\033[0;00m\\]%s\\[\\033[0;0m\\]" " : " 
	printf "\\[\\033[1;34m\\]%s\\[\\033[0;0m\\]" "\\w "
	printf "\\[\\033[0;33m\\]%s\\[\\033[0;0m\\]" "$ "
	printf "\";"
} > ~/.bashrc
