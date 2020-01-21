import React from "react";
import { render, } from "react-dom";
import { createOvermind } from 'overmind'
import { Provider} from 'overmind-react'
import { config } from "./src/overmind";
import App from "./src/App";

const getAppEnv = () => 'local';

const overmind = createOvermind(config);

window.log = getAppEnv() !== "prod" ? console.log : () => {};

log(`Running in "${getAppEnv()}" mode.`);

// render the application
function renderApp() {
	render(
		<Provider value={overmind}>
			<App />
		</Provider>,
		document.getElementById("root")
	);
}

renderApp();

module.hot.accept();
