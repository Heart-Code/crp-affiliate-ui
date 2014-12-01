Reflux = require 'reflux'

UserActions = Reflux.createActions [
	'getCurrent'
	'edit'
	'create'
	'addPoints'
	'changePassword'
]

module.exports = UserActions