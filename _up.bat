@echo off
setlocal EnableDelayedExpansion
setlocal EnableExtensions

cls;

if exist .\.env (
	echo Reading .env file
) else (
	echo Creating .env file
	bash _up.sh
)

echo(
type .\.env
echo(

docker-compose up --remove-orphans --build