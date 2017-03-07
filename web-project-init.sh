#!/bin/bash

if [ $# -eq 1 ]
then
	project=$1;
	makeDir=1;

	if [ -d $project ]
	then
		echo "";
		echo "The $project directory already exists.";
		echo -n "Do you want to delete it? [N/y] ";
		read -n 1 delDir;
		echo "";

		if [ -z $delDir ]
		then
			delDir='n';
		fi

		if [ $delDir = 'y' ]
		then
			rm -Rf $project;
		else
			makeDir=0;
		fi
	fi

	if [ $makeDir -eq 1 ]
	then
		echo "";
		echo "Creating web-app '$project'";

		mkdir $project;
		cd $project;

		echo "";
		echo -n "Do you wish to install nvm? [N/y] ";
		read -n 1 nvm;
		echo "";

		if [ -z $nvm ]
		then
			nvm='n';
		fi

		if [ $nvm = 'y' ]
		then
			echo 'Installing nvm';
			echo "";

			touch ~/.bash_profile
			curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
			export NVM_DIR="$HOME/.nvm"
			[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

			echo "";
			echo -n "Do you want to install node 7.x? [N/y] ";
			read -n 1 node;
			echo "";

			if [ -z $node ]
			then
				node='n';
			fi

			if [ $node = 'y' ]
			then
				echo "Installing node 7";
				echo "";
				nvm install 7;
				nvm use 7;
			fi
		fi

		echo "";

		nvm use 7
		npm prune
		npm cache clean

# package.json
cat <<EOT >> package.json
{
	"dependencies": {},
	"devDependencies": {},
	"scripts": {
		"serve": "webpack-dev-server --content-base src --hot --inline --port 3000",
		"build": "rm -rf ./dist && gulp webpack"
	},
	"main": "index.js",
	"version": "0.1.0",
	"author": "",
	"description": "",
	"name": "$project",
	"private": true
}
EOT

		npm init -y --main="index.js" --version="0.0.1"

		# react: view, mobx: store/data
		depInstall="react react-router react-dom mobx mobx-react"
		# webpack: kick off, gulp: actioner, axios: ajax, co: generator iterator
		frameInstall="webpack webpack-dev-server gulp react-addons-test-utils axios co"
		# babel: transpiler
		babelInstall="babel-core babel-loader babel-preset-es2015 babel-preset-react babel-plugin-transform-class-properties babel-plugin-transform-decorators-legacy"
		# sass: css compiler
		sassInstall="node-sass normalize-scss style-loader css-loader sass-loader"

		# depen
		for i in `echo $depInstall`
		do
			npm install $i --save --silent
		done

		# dev dependencies
		for i in `echo $frameInstall $babelInstall $sassInstall`
		do
			npm install $i --save-dev --silent
		done

		npm install

# webpack configs
cat <<EOT >> webpack.config.js
var webpack = require('webpack');
var path = require('path');

var debug = process.env.NODE_ENV !== 'production';

module.exports = {
	context: path.join(__dirname, "src"),
	devtool: (debug ? "inline-sourcemap" : false),
	entry: "./routes/_$project.js",
	devServer: (debug ? {
		overlay: true,
	} : {}),
	module: {
		loaders: [
			{
				test: /\.js$/,
				exclude: /(node_modules|bower_components)/,
				loader: 'babel-loader',
			},
			{ test: /\.css$/, loader: "style-loader!css-loader" },
			{ test: /\.scss$/, loader: "style-loader!css-loader!sass-loader" },
		]
	},
	output: {
		path: path.join(__dirname, (debug ? "src" : "dist")),
		filename: "$project.min.js"
	},
	plugins: (debug ? [] : [
		new webpack.optimize.DedupePlugin(),
		new webpack.optimize.UglifyJsPlugin({
			beautify: false,
			mangle: {
				screw_ie8: true,
				keep_fnames: false
			},
			compress: {
				screw_ie8: true
			},
			comments: false
		})
	]),
};
EOT

# gulp file
cat <<EOT >> gulpfile.js
var gulp = require('gulp');
var exec = require('child_process').exec;

// Generate minified bundle
gulp.task('webpack', ['copy'], function(cb) {
	exec('webpack --optimize-minimize --define process.env.NODE_ENV="\'production\'"', function (err, stdout, stderr) {
		if (err) { cb(err) }

		console.log(stdout);
		console.log(stderr);
	});
});

gulp.task('copy', function () {
	// html
	gulp.src('./src/index.html')
		.pipe(gulp.dest('./dist/'));

	// assets
	gulp.src('./src/assets/**/*')
		.pipe(gulp.dest('./dist/assets/'));
});
EOT

# babel
cat <<EOT >> .babelrc
{
	"presets": [
		"react",
		"es2015"
	],
	"plugins": [
		"transform-decorators-legacy",
		"transform-class-properties"
	]
}
EOT

# eslint
cat <<EOT >> .eslintrc
{
	"plugins": [
		"react"
	],
	"extends": [
		"eslint:recommended",
		"plugin:react/recommended"
	],
	"rules": {
		"no-set-state": "off"
	}
}
EOT

# git ignore
cat <<EOT >> .gitignore
.DS_Store
node_modules
EOT

# entrypoint
mkdir src
mkdir src/styles
mkdir src/routes
mkdir src/stores
mkdir src/components
cat <<EOT >> ./src/index.html
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>init-working</title>
		<meta name="description" content="">
		<meta name="viewport" content="width=device-width">
	</head>
	<body>
		<!--[if lt IE 10]>
			<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
		<![endif]-->

		<div id="root"></div>
		<script src="$project.min.js"></script>
	</body>
</html>
EOT
cat <<EOT >> ./src/styles/_$project.scss
@import "../../node_modules/normalize-scss/fork-versions/default/normalize";

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

#webpack-dev-server-client-overlay{
	opacity: .9 !important;
}
EOT
cat <<EOT >> ./src/routes/_$project.js
import '../styles/_$project.scss'
import React from 'react'
import ReactDOM from 'react-dom'
import { Router, Route, browserHistory } from 'react-router'
import { Provider } from 'mobx-react'

import Todos from '../components/Todos'
import todoStore from '../stores/TodoStore'

const app = document.getElementById('root');

ReactDOM.render(
	<Provider store={todoStore}>
		<Router history={browserHistory}>
			<Route path="/" component={Todos}/>
		</Router>
	 </Provider>,
	app
)
EOT
cat <<EOT >> ./src/components/Todos.js
import React, { Component } from 'react'
import { inject, observer } from 'mobx-react'

import Todo from './Todo'

@inject('store')
@observer
export default class Todos extends Component {
	constructor() {
		super()

		this.handleCreateKeypress = this.handleCreateKeypress.bind(this)
		this.handleFilterChange = this.handleFilterChange.bind(this)
	}

	handleCreateKeypress(event) {
		if (event.which === 13) { // enter key
			this.props.store.createTodo(event.target.value) // add todo
			event.target.value = '' // clear todo text
		}
	}

	handleFilterChange(event) {
		this.props.store.filter = event.target.value
	}

	render() {
		const { completedTodos, filter, filteredTodos, todos } = this.props.store

		const todoList = filteredTodos.map(todo => (<Todo key={todo.id} todo={todo} />))

		const todoneList = completedTodos.map(todo => (<Todo key={todo.id} todo={todo} />))

		return (
			<div>
				<input placeholder="creat new" className="create" onKeyPress={this.handleCreateKeypress} />
				<input placeholder="filter" className="filter" value={filter} onChange={this.handleFilterChange} />

				<h1>Todo List</h1>

				<ul>{todoList}</ul>

				<h1>Todone List</h1>

				<ul>{todoneList}</ul>
			</div>
		);
	}
}
EOT
cat <<EOT >> ./src/components/Todo.js
import React, {Component} from 'react'
import { inject, observer } from 'mobx-react'

@observer
export default class Todo extends Component {
	constructor() {
		super()

		this.handleCompleteToggle = this.handleCompleteToggle.bind(this)
	}

	handleCompleteToggle(e) {
		this.props.todo.complete = !this.props.todo.complete
	}

	render() {
		return (
			<li key={this.props.todo.id}>
				<input
					type="checkbox"
					value={this.props.todo.complete}
					checked={this.props.todo.complete}
					onChange={this.handleCompleteToggle}
				/>
				{this.props.todo.value}
			</li>
		);
	}
}
EOT
cat <<EOT >> ./src/stores/TodoStore.js
import React, {Component} from 'react'
import { computed, observable } from 'mobx'

class Todo {
	@observable id
	@observable value
	@observable complete

	constructor(value) {
		this.value = value
		this.id = Date.now()
		this.complete = false
	}
}

export class TodoStore {
	@observable todos = []
	@observable filter = ''

	@computed get filteredTodos() {
		let matchedFilters = new RegExp(this.filter, 'i')

		return this.todos.filter(todo => {
			let passesFilter = !this.filter || matchedFilters.test(todo.value)
			let notDone = !todo.complete

			return passesFilter && notDone
		})
	}

	@computed get completedTodos() {
		let matchedFilters = new RegExp(this.filter, 'i')

		return this.todos.filter(todo => {
			let passesFilter = !this.filter || matchedFilters.test(todo.value)
			let isDone = todo.complete

			return passesFilter && isDone
		})
	}

	createTodo(todo) {
		this.todos.push(new Todo(todo))
	}
}

export default new TodoStore
EOT

	fi
else
	echo "";
	echo "ERROR: Please provide a project name.";
	echo "";
fi