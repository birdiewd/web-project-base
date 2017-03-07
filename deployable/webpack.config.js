var webpack = require('webpack');
var path = require('path');

var debug = process.env.NODE_ENV !== 'production';

module.exports = {
	context: path.join(__dirname, "src"),
	devtool: (debug ? "inline-sourcemap" : false),
	entry: "./routes/_deployable.js",
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
		filename: "deployable.min.js"
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
