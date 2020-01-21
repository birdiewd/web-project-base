import React from "react";
import ReactDOM from "react-dom";
import { createOvermind } from 'overmind'
import { createHook, Provider} from 'overmind-react'
import { config } from "./src/overmind";
import App from "./src/App";

const getAppEnv = () => 'local';

const overmind = createOvermind(config);
const useOvermind = createHook();

window.log = getAppEnv() !== "prod" ? console.log : () => {};

log(`Running in "${getAppEnv()}" mode.`);

// render the application
function renderApp() {
	ReactDOM.render(
		<Provider value={overmind}>
			<App store={useOvermind} />
		</Provider>,
		document.getElementById("root")
	);
}

renderApp();

module.hot.accept();
