var webpack = require('webpack');
var path = require('path');

module.exports = {
	context: path.join(__dirname, "src"),
	devtool: "inline-sourcemap",
	entry: "./components/app.js",
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
		path: path.join(__dirname, "src"),
		filename: "$project.min.js"
	},
};
