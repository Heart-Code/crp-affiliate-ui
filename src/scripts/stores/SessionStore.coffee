Reflux = require 'reflux'
request = require 'superagent'
LoginActions = require '../actions/LoginActions'

SessionStore = Reflux.createStore
	init: ->
		@listenToMany LoginActions

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
			.post 'http://api.crp.eridlabs.com/oauth2/token'
			.auth '546a239d5021eee0313af9d1', '7H1515A53C437'
			.send { username, password, grant_type: 'password' }
			.end (res) =>
				if res.ok
					@setAccessToken res.body.access_token

				@trigger res.status
			.on 'error', (err) =>
				console.log err
				if res.unauthorized
					console.log 'HA!'
				if res.forbidden
					console.log 'HA!'
	onLogout: ->
		@removeAccessToken()
		@trigger null

module.exports = SessionStore