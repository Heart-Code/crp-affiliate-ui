Reflux = require 'reflux'
request = require 'superagent'
LoginActions = require '../actions/LoginActions'

LoginStore = Reflux.createStore
	init: ->
		@listenToMany LoginActions
	onLogin: (username, password) ->
		request
			.post 'http://localhost:3000/oauth2/token'
			.type 'form'
			.auth '546a239d5021eee0313af9d1', '7H1515A53C437'
			.send { username, password, grant_type: 'password' }
			.end (res) =>
				if res.ok
					sessionStorage.setItem 'access_token', res.body.access_token

				@trigger res.status

module.exports = LoginStore