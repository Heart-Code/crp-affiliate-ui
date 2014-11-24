request = require 'superagent'
Response = request.Response
SessionActions = require '../actions/SessionActions'
#SessionStore = require '../stores/SessionStore'

config =
	api_url: 'http://localhost:3000'
	api_key: '546a239d5021eee0313af9d1'
	api_secret: '7H1515A53C437'

# Middleware to set the API URL prefix
prefix = (request) ->
	if request.url[0] is '/'
		request.url = config.api_url + request.url

	request

errorHandling = (request) ->
	# Hack to add a callback first to handle auth responses
	request._callbacks.end.unshift ->
		err = null
		res = null

		try
			res = new Response this
		catch e
			err = new Error 'Parser is unable to parse the response'
			err.parse = true
			err.original = e

		# Call the corresponding actions
		if res.unauthorized
			SessionActions.unauthorized()
		if res.forbidden
			SessionActions.forbidden()

	request.on 'error', (err) ->
		# TODO: Appropiately handle a request error
		console.error err

authorize = (request, next) ->
	SessionStore = require '../stores/SessionStore'	# Apparently not all dependencies can be called at definition
	token = SessionStore.getAccessToken()
	if token then request.set 'Authorization', "Bearer #{token}"

	request
		.use prefix
		.use errorHandling

login = (username, password) ->
	(request) ->
		request
			.use prefix
			.use errorHandling
			.auth config.api_key, config.api_secret
			.send { username, password, grant_type: 'password' }

module.exports = {request, authorize, login}