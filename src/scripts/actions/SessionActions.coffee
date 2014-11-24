Reflux = require 'reflux'

SessionActions = Reflux.createActions [
	'login'
	'logout'
	'unauthorized'
	'forbidden'
]

module.exports = SessionActions