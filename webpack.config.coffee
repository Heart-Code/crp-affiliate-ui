path = require 'path'
webpack = require 'webpack'

module.exports =
	entry: [
		'webpack-dev-server/client?http://localhost:8080'
		'webpack/hot/dev-server'
		'./src/scripts/main'
	]
	devTool: 'source-map'
	debug: true
	node:
		fs: 'empty'
	output:
		path: path.join __dirname, 'public/js'
		filename: 'main.js'
	resolveLoader:
		modulesDirectory: ['node_modules']
	plugins: [
		new webpack.HotModuleReplacementPlugin()
		new webpack.IgnorePlugin /vertx/ # https://github.com/webpack/webpack/issues/353
	]
	resolve:
		extensions: ['', '.js', '.cjsx', '.coffee']
	module:
		loaders: [
			{ test: /\.css/, loaders: ['style']}
			{ test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx']}
			{ test: /\.coffee$/, loader: 'coffee' }
		]