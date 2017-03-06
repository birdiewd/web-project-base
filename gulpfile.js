var gulp = require('gulp');
var exec = require('child_process').exec;

// Generate minified bundle
gulp.task('webpack', ['copy'], function(cb) {
	exec('webpack --optimize-minimize --define process.env.NODE_ENV="\'production\'"', function (err, stdout, stderr) {
		if (err) { cb(err) }

		console.log(`stdout: ${stdout}`);
		console.log(`stderr: ${stderr}`);
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
