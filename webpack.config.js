var webpack = require('webpack');
var path = require('path');

module.exports = {
	context: path.join(__dirname, "src"),
	devtool: false,
	entry: "./routes/_$project.js",
	module: {
		loaders: [
			{
				test: /\.js$/,
				exclude: /(node_modules|bower_components)/,
				loader: 'babel-loader',
			},
			{ test: /\.css$/, loader: "style-loader!css-loader"},
			{ test: /\.scss$/, loader: "style-loader!css-loader!sass-loader"}
		]
	},
	output: {
		path: path.join(__dirname, "dist"),
		filename: "$project.min.js"
	},
	plugins: [
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
	],
};
