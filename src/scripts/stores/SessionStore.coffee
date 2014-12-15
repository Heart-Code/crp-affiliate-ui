Reflux = require 'reflux'
{request, login} = require '../utils/Request'
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
		request
			.post '/oauth2/token'
			.use login username.toLowerCase().trim(), password
			.end (res) =>
				if res.ok
					@setAccessToken res.body.access_token

				@trigger res.status
	onLogout: ->
		@removeAccessToken()
		@trigger null
	onUnauthorized: ->
		@trigger 401	# TODO: Use constants
	onForbidden: ->
		@trigger 403

module.exports = SessionStore