# Web Project Base

*Mostly an advanced git gist.*

I recommend not cloning this but downloading a zip of it and unzipping it into your project directory before you get started.

## Containers
- **web** - React based project using ParcelJS for bundling, serving, and HMR.
- **api** - An express server that can connect to a mysql database.
- **db** - A mysql database.

---

## Pre-requisites

**Bash**
- GitBash if you're on Windows works great, otherwise, your OS should have a default of bash/sh/zsh
- https://gitforwindows.org/

**Docker**
- This will be the container system we use from the bash prompt
- https://www.docker.com/products/docker-desktop

## Recommendations

**HyperJS**
- This is my command line emulator of choice
- https://hyper.is/
- Update your .hyper.js config file if you use GitBash
```js
module.exports = {
	config: {
		// ...
		shell: 'C:\\Program Files\\Git\\git-cmd.exe',
		shellArgs: ['--command=usr/bin/bash.exe', '-l', '-i'],
		env: { TERM: 'cygwin'},
		// ...
	}
}
```

---

## Starting the docker container(s)

```bash
./_up.sh # this is required for the first run and is recommended for all subsequent runs
# - or -
./_up.sh db
# - or -
./_up.sh api
# - or -
./_up.sh web
```
This starts the docker container(s). 

*First Run:* You will be prompted for some service and port number information.

## Accessing the docker container(s)

```bash
./_shell.sh db
# - or -
./_shell.sh api
# - or -
./_shell.sh web
```

## Stopping the docker container(s)

```bash
./_up.sh # this will bring down all containers spawned from the docker-compose.yml file
# - or -
./_up.sh db
# - or -
./_up.sh api
# - or -
./_up.sh web
```
