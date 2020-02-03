const mysql = require("mysql");
const dotenv = require("dotenv");
dotenv.config();

//local mysql db connection
const connection = mysql.createConnection({
	host: "172.17.0.1",
	user: "admin",
	password: "admin",
	database: "default",
	port: process.env.DB_PORT,
	multipleStatements: true
});

connection.connect(function(err) {
	if (err) throw err;
});

module.exports = connection;
