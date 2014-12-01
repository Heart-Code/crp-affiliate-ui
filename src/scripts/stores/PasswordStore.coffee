Reflux = require 'reflux'
UserActions = require '../actions/UserActions'
{request, authorize, prefix} = require '../utils/Request'

PasswordStore = Reflux.createStore
	init: ->
		@listenTo UserActions.changePassword, @onChangePassword

	onChangePassword: (oldPassword, password) ->
		request
			.patch '/user'
			.use authorize
			.send {oldPassword, password}
			.end (res) =>
				console.log res
				if res.ok
					@trigger res.body

module.exports = PasswordStore