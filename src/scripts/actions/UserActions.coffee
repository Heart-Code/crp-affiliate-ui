Reflux = require 'reflux'

UserActions = Reflux.createActions [
	'getCurrent'
	'edit'
	'create'
	'addPoints'
]

module.exports = UserActions