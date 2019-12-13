@echo off
setlocal EnableDelayedExpansion
setlocal EnableExtensions

set $current_dir = pwd; 
set $current_dir = ${current_dir} -replace '^.*\\';

docker-compose down
docker rmi ${current_dir}_ui --force

rmdir /S /Q node_modules
