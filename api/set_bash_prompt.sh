#!/bin/bash

PROJECT_NAME=$(cat .iam)
CONTAINER_TYPE=api

echo "" >> ~/.bashrc
{
	printf "PS1=\"\\[\\033[36m\\]%s " "$PROJECT_NAME"
	printf "\\[\\033[35m\\](%s) " "$CONTAINER_TYPE"
	printf "\\[\\033[0m\\]: \\[\\033[1;34m\\]\\w \\[\\033[0;33m\\]\\$ \\[\\033[0m\\]\""
} >> ~/.bashrc