const chalk = require("chalk")
const dotenv = require("dotenv");

dotenv.config();

const iHas = (process.env.I_HAS || "").split(",");

const projectInfo = () => {
	return `
	${chalk.bold(chalk.red(process.env.PROJECT_NAME))}
	`
}

const webInfo = () => {
	const hasWeb = iHas.includes('web');

	if(hasWeb){
		return `
	${chalk.cyan("WEB")}:	http://localhost:${chalk.yellow(
		process.env.WEB_PORT
	)} (hmr: ${chalk.yellow(process.env.WEB_HMR_PORT)})
		`
	}

	return '';
}

const apiInfo = () => {
	const hasApi = iHas.includes('api');

	if (hasApi) {
		return `
	${ chalk.cyan("API") }:	http://localhost:${chalk.yellow(process.env.API_PORT)}
		`
	}

	return '';
}

const dbInfo = () => {
	const hasDb = iHas.includes('db');

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

console.log(`









${chalk.grey("===================================================")}
${projectInfo()}${webInfo()}${apiInfo()}${dbInfo()}
${chalk.grey("===================================================")}`);