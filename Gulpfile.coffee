gulp = require 'gulp'
webserver = require 'gulp-webserver'
coffee = require 'gulp-coffee'
sass = require 'gulp-ruby-sass'
jade = require 'gulp-jade'
browserify = require 'gulp-browserify'
clean = require 'gulp-clean'
rename = require 'gulp-rename'
plumber = require 'gulp-plumber'

browserify_ws = require 'browserify'
coffeeify  = require 'coffeeify'
source = require 'vinyl-source-stream'
mold = require 'mold-source-map'

path =
	app: 'public'
	process:
		scripts: 'src/scripts/main.coffee'
		styles: 'src/styles/*.sass'
		views: ['src/views/**/*.jade', '!src/views/partials/*.jade']
	watch:
		scripts: 'src/scripts/**/*.coffee'
		styles: 'src/styles/**/*.sass'
		views: 'src/views/**/*.jade'


# Processor tasks
gulp.task 'scripts', ->
	gulp.src path.process.scripts, read: false
		.pipe plumber()
		.pipe browserify
			debug: true
			transform: 'coffeeify'
			extensions: '.coffee'
		.pipe rename 'main.js'
		.pipe gulp.dest 'public/js'

gulp.task 'scripts-ws', ->
	browserify_ws './' + path.process.scripts,
			debug: true
			extensions: '.coffee'
		.transform coffeeify
		.bundle()
		.on 'error', (err) ->
			console.log err.message
			@end()
		.pipe mold.transformSourcesRelativeTo 'public/js'
		.pipe source 'main.js'
		.pipe gulp.dest 'public/js'

gulp.task 'styles', ->
	gulp.src path.process.styles
		.pipe plumber()
		.pipe sass
			#sourcemap: true
			lineNumbers: true
		.pipe gulp.dest 'public/css'

gulp.task 'views', ->
	gulp.src path.process.views
		.pipe plumber()
		.pipe jade
			pretty: true
		.pipe gulp.dest 'public'

gulp.task 'scripts-prod', ->
	gulp.src path.process.scripts, read: false
		.pipe plumber()
		.pipe browserify
			transform: 'coffeeify'
			extensions: '.coffee'
		.pipe rename 'main.js'
		.pipe gulp.dest 'public/js'

gulp.task 'styles-prod', ->
	gulp.src path.process.styles
		.pipe plumber()
		.pipe sass()
		.pipe gulp.dest 'public/css'

gulp.task 'views-prod', ->
	gulp.src path.process.views
		.pipe plumber()
		.pipe jade()
		.pipe gulp.dest 'public'

# Misc tasks
gulp.task 'clean', ->
	gulp.src path.app + '/*', read: false
		.pipe clean()

gulp.task 'connect', ->
	gulp.src path.app
		.pipe webserver
			root: path.app
			port: 8080
			livereload: true
			open: true
			fallback: 'index.html'

gulp.task 'connect-prod', ->
	gulp.src path.app
		.pipe webserver
			root: path.app
			port: 8080
			fallback: 'index.html'

gulp.task 'watch', ->
	gulp.watch path.watch.scripts, ['scripts']
	gulp.watch path.watch.styles, ['styles']
	gulp.watch path.watch.views, ['views']

gulp.task 'default', ['scripts', 'styles', 'views', 'connect', 'watch']
gulp.task 'build', ['scripts-prod', 'styles-prod', 'views-prod']