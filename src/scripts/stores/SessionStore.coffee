Reflux = require 'reflux'
request = require 'superagent'
SessionActions = require '../actions/SessionActions'

SessionStore = Reflux.createStore
	init: ->
		@listenToMany SessionActions

	setAccessToken: (accessToken) ->
		localStorage.setItem 'access_token', accessToken
	removeAccessToken: ->
		localStorage.removeItem 'access_token'
	getAccessToken: ->
		localStorage.getItem 'access_token'

	# Actions
	onLogin: (username, password) ->
		# TODO: prefix(request)
		# TODO: use(bearer)
		# TODO:
		request
			.post 'http://localhost:3000/oauth2/token'
			.auth '546a239d5021eee0313af9d1', '7H1515A53C437'
			.send { username, password, grant_type: 'password' }
			.end (res) =>
				if res.ok
					@setAccessToken res.body.access_token

				@trigger res.status
	onLogout: ->
		@removeAccessToken()
		@trigger null
	onUnauthorized: ->
		@trigger 401
	onForbidden: ->
		@trigger 403

module.exports = SessionStore