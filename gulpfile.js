var gulp = require('gulp');
var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var exec = require('child_process').exec;

gulp.task('webpack-dev-server', function(callback) {
	var config = require('./webpack.dev.config.js');
	var compiler = webpack(config);
	var server = new WebpackDevServer(compiler, {
		contentBase: "src",
		hot: true,
		inline: true,
		stats: {
			colors: true
		}
	});

	server.listen(3000, "localhost");
});

// Generate minified bundle
gulp.task('webpack', ['copy'], function(cb) {
	exec('webpack --optimize-minimize --define process.env.NODE_ENV="\'production\'"', function (err, stdout, stderr) {
		console.log(stdout);
		console.log(stderr);
		cb(err);
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