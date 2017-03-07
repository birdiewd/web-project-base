var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var path = require('path');

module.exports = {
	context: path.join(__dirname, "src"),
	devtool: "inline-sourcemap",
	devServer: {
		overlay: true,
	},
	entry: "./routes/_$project.js",
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
