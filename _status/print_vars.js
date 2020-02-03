const chalk = require("chalk")
const dotenv = require("dotenv")
const axios = require("axios");

dotenv.config();

const iHas = (process.env.I_HAS || "").split(",");
const hasWeb = iHas.includes('web');
const hasApi = iHas.includes('api');
const hasDb = iHas.includes('db');

let fetches = [];

if (hasWeb) {
	fetches.push(
		axios(`http://host.docker.internal:${process.env.WEB_PORT}`)
			.then(data => chalk.green('up'))
			.catch(error => chalk.red('down'))
	);
}

if (hasApi) {
	fetches.push(
		axios(`http://host.docker.internal:${process.env.API_PORT}`)
			.then(data => chalk.green('up'))
			.catch(error => chalk.red('down'))
	);
}

const projectInfo = () => {
	return `
	${chalk.bold(chalk.red(process.env.PROJECT_NAME))}
	`
}

const webInfo = status => {
	if (hasWeb) {
		return `
	${chalk.cyan("WEB")}:	http://localhost:${chalk.yellow(
			process.env.WEB_PORT
		)} (hmr: ${chalk.yellow(process.env.WEB_HMR_PORT)}) ${status}
		`;
	}

	return "";
};

const apiInfo = status => {
	if (hasApi) {
		return `
	${chalk.cyan("API")}:	http://localhost:${chalk.yellow(
			process.env.API_PORT
		)} ${status}`;
	}

	return "";
};

const dbInfo = () => {
	if (hasDb) {
		return `
	${chalk.cyan("DB")}:	Server:   ${chalk.yellow("localhost")}
		Port:     ${chalk.yellow(process.env.DB_PORT)}
		Database: ${chalk.yellow("default")}
		Username: ${chalk.yellow("admin")}
		Password: ${chalk.yellow("admin")}
		`
	}

	return '';
}

Promise.all(fetches).then(results => {
	const apiStatus = hasApi ? results.pop() : '';
	const webStatus = hasWeb ? results.pop() : "";

	console.log(`
	
	
	
	
	
	
	
	
	
	${chalk.grey("===================================================")}
	${projectInfo()}${webInfo(webStatus)}${apiInfo(apiStatus)}${dbInfo()}
	${chalk.grey("===================================================")}`);
})
