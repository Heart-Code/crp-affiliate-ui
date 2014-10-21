gulp = require 'gulp'
connect = require 'gulp-connect'
coffee = require 'gulp-coffee'
sass = require 'gulp-ruby-sass'
jade = require 'gulp-jade'
browserify = require 'gulp-browserify'
clean = require 'gulp-clean'
rename = require 'gulp-rename'
plumber = require 'gulp-plumber'
historyApiFallback = require 'connect-history-api-fallback'

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

			shim:
				react:
					path: 'lib/react.js'
					exports: 'react'
		.pipe rename 'main.js'
		.pipe gulp.dest 'public/js'
		.pipe connect.reload()

gulp.task 'styles', ->
	gulp.src path.process.styles
		.pipe plumber()
		.pipe sass
			#sourcemap: true
			lineNumbers: true
		.pipe gulp.dest 'public/css'
		.pipe connect.reload()

gulp.task 'views', ->
	gulp.src path.process.views
		.pipe plumber()
		.pipe jade
			pretty: true
		.pipe gulp.dest 'public'
		.pipe connect.reload()

# Misc tasks
gulp.task 'clean', ->
	gulp.src path.app + '/*', read: false
		.pipe clean()

gulp.task 'connect', ->
	connect.server
		root: path.app
		port: 8080
		livereload: true
		middleware: ->
			[historyApiFallback]	# This allows for requests being sent to index.html

gulp.task 'watch', ->
	gulp.watch path.watch.scripts, ['scripts']
	gulp.watch path.watch.styles, ['styles']
	gulp.watch path.watch.views, ['views']

gulp.task 'default', ['scripts', 'styles', 'views', 'connect', 'watch']