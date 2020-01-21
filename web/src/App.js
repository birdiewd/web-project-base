import { hot } from "react-hot-loader";

import React, { useEffect, } from "react";
import PropTypes from "prop-types";

import { BrowserRouter } from "react-router-dom";
import { Route } from "react-router";

import "./App.less";

const pTypes = {
};

const dProps = {
};

const App = (props) => {
	const {
		store,
	} = props;

	const {
		state,
		actions,
	} = store();

	useEffect(() => {
		// actions.getStuffById(4);
		actions.getStuff();
	}, [])

	return (
		<div className="app">
			{state.count}
			<pre>
				{JSON.stringify(state.stuff, null, 2)}
			</pre>
		</div>
	);
};

App.propTypes = pTypes;
App.defaultProps = dProps;

export default hot(module)(App);
