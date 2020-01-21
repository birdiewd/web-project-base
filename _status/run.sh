#!/usr/bin/env bash
set -eo pipefail

npm install --silent;

node /usr/app/print_vars.js;

# touch ready.txt
# tail -f ready.txt
# rm ready.txt