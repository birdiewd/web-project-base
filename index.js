import React from 'react';
import ReactDOM from 'react-dom';
import getAppEnv from './getAppEnv';

window.devlog = getAppEnv() !== "prod" ? console.log : () => {};

devlog(`Running in "${getAppEnv()}" mode.`);

// import configureStore from './src/store/configureStore';

// import { preloadedState, } from './src/store/preloadedState';

// import './index.less';
// import './src/styles/settings.less';

// import App from './src/App';
const App = () => (
	<div>App Started</div>
);

// Configure redux store;
// const store = configureStore(preloadedState);
const store = {};

// render the application
function renderApp() {
	ReactDOM.render(
		<App store={store} />,
		document.getElementById('root')
	);
}

renderApp();

module.hot.accept();
