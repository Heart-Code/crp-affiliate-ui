path = require 'path'
webpack = require 'webpack'

module.exports =
	entry: [
		'./src/scripts/main'
	]
	node:
		fs: 'empty'
	output:
		path: path.join __dirname, 'public/js'
		filename: 'main.js'
	resolveLoader:
		modulesDirectory: ['node_modules']
	plugins: [
		new webpack.IgnorePlugin /vertx/ # https://github.com/webpack/webpack/issues/353
		new webpack.optimize.UglifyJsPlugin()
	]
	resolve:
		extensions: ['', '.js', '.cjsx', '.coffee']
	module:
		loaders: [
			{ test: /\.cjsx$/, loaders: ['coffee', 'cjsx']}
			{ test: /\.coffee$/, loader: 'coffee' }
		]