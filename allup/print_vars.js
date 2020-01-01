const chalk = require("chalk")
const dotenv = require("dotenv");

dotenv.config();

console.log(`









${chalk.grey("===================================================")}
	${chalk.bold(chalk.red(process.env.PROJECT_NAME))}

	${chalk.cyan("WEB")}:	http://localhost:${chalk.yellow(
	process.env.WEB_PORT
)} (hmr: ${chalk.yellow(process.env.WEB_HMR_PORT)})
	
	${chalk.cyan("API")}:	http://localhost:${chalk.yellow(process.env.API_PORT)}
	
	${chalk.cyan("DB")}:	Server:   ${chalk.yellow("localhost")}
		Port:     ${chalk.yellow(process.env.DB_PORT)}
		Database: ${chalk.yellow("default")}
		Username: ${chalk.yellow("admin")}
		Password: ${chalk.yellow("admin")}
${chalk.grey("===================================================")}
`);