#!/usr/bin/env sh

PROJECT_NAME=$(cat .iam)
echo "" >> ~/.bashrc
echo 'PS1="'"$PROJECT_NAME"' (web) : \u : \w \\$ "' >> ~/.bashrc
