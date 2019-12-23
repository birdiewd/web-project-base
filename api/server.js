const express = require('express')
const dotenv = require("dotenv")

const app = express()

dotenv.config();

const port = process.env.API_PORT;

app.get('/', (req, res) => res.json({here: "here"}))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))