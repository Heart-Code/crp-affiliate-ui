gulp = require 'gulp'
webserver = require 'gulp-webserver'
sass = require 'gulp-sass'
clean = require 'gulp-clean'
rename = require 'gulp-rename'
plumber = require 'gulp-plumber'
connect = require 'gulp-connect'

webpackConfig = require './webpack.config'
webpackProdConfig = require './webpack.production.config'
gutil = require 'gulp-util'
webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
touch = require 'touch'
open = require 'open'

$ = require('gulp-load-plugins')()

path =
	app: 'public'
	process:
		scripts: 'src/scripts/main.coffee'
		styles: 'src/styles/*.sass'
	watch:
		scripts: 'src/scripts/**/*.{coffee,cjsx}'
		styles: 'src/styles/**/*.sass'
		assets: 'assets/**'
		js: 'public/js/**/*.js'


# Processor tasks
gulp.task 'styles', ->
	gulp.src path.process.styles
		.pipe plumber()
		.pipe sass sourceComments: 'normal'
		.pipe gulp.dest 'public/css'
		.pipe connect.reload()

# We need to cache the webpack
devCompiler = webpack webpackConfig
gulp.task 'webpack:build-dev', (callback) ->
	devCompiler.run (err, stats) ->
		if err then throw new gutil.PluginError 'webpack:build-dev', err
		gutil.log '[webpack:build-dev]', stats.toString colors: true
		callback()

# We need to cache the webpack
prodCompiler = webpack webpackProdConfig
gulp.task 'webpack:build', (callback) ->
	prodCompiler.run (err, stats) ->
		if err then throw new gutil.PluginError 'webpack:build', err
		gutil.log '[webpack:build]', stats.toString colors: true
		callback()

devServer = {}
gulp.task 'webpack-dev-server', (callback) ->
	# Make sure there's a css file that can be required
	touch.sync './public/css/main.css', time: new Date(0)

	serverCompiler = webpack webpackConfig
	devServer = new WebpackDevServer serverCompiler,
		contentBase: './public/'
		hot: true
		watchDelay: 100
		noInfo: true
		stats:
			colors: true

	devServer.listen 8080, 'localhost', (err) ->
		if err then throw new gutil.PluginError 'webpack-dev-server', err
		gutil.log '[webpack-dev-server]', 'http://localhost:8080'
		callback()

gulp.task 'copy-assets', ->
	gulp.src path.watch.assets
		.pipe gulp.dest 'public'
		.pipe $.size()

gulp.task 'js-livereload', ->
	gulp.src path.watch.js
		.pipe connect.reload()

# Misc tasks
gulp.task 'clean', ->
	gulp.src path.app + '/*', read: false
		.pipe clean()

gulp.task 'connect', ->
	port = gulp.env.p || gulp.env.port || 8080
	connect.server
		root: path.app
		livereload: true
		port: port
	open "http://localhost:#{port}"

gulp.task 'watch', ['styles', 'copy-assets', 'webpack:build-dev'], ->
	gulp.start 'connect'
	gulp.watch path.watch.scripts, ['webpack:build-dev']
	gulp.watch path.watch.js, ['js-livereload']	# We want immediate live reloading
	gulp.watch path.watch.styles, ['styles']
	gulp.watch path.watch.assets, ['copy-assets']

# TODO: Make it work with Webpack Hot Module Replacement plugin
gulp.task 'watch-test', ['styles', 'copy-assets', 'webpack-dev-server'], ->
	gulp.watch path.watch.styles, ['styles']
	gulp.watch path.watch.assets, ['copy-assets']

gulp.task 'default', ->
	gulp.start 'build'

gulp.task 'build', ['webpack:build', 'styles', 'copy-assets']