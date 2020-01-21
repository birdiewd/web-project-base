import { hot } from "react-hot-loader";

import React, { useEffect, } from "react";
import PropTypes from "prop-types";

import { BrowserRouter } from "react-router-dom";
import { Route } from "react-router";

import { useOvermind, } from './overmind'

import "./App.less";

const pTypes = {
};

const dProps = {
};

const SubThing = (props) => {
	const {
		state,
		actions,
	} = useOvermind();

	useEffect(() => {
		// actions.getStuffById(4);
		actions.getStuff();
	}, []);

	return (
		<pre>
			{JSON.stringify(state.stuff, null, 2)}
		</pre>
	)
}

const App = (props) => {
	const {
		state,
	} = useOvermind();

	return (
		<div className="app">
			{state.count}
			<SubThing />
		</div>
	);
};

App.propTypes = pTypes;
App.defaultProps = dProps;

export default hot(module)(App);
