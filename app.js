var gulp = require('gulp');
var webserver = require('gulp-webserver');

gulp.task('connect', function() {
	gulp.src('public')
		.pipe(webserver({
			port: 8080,
			fallback: 'index.html'
		}));
});

gulp.start('connect');