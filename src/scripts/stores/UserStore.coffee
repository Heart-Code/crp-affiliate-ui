Reflux = require 'reflux'
{request, authorize, prefix} = require '../utils/Request'
UserActions = require '../actions/UserActions'
SessionActions = require '../actions/SessionActions'
SessionStore = require './SessionStore'

UserStore = Reflux.createStore
	init: ->
		@user = {}

		@listenToMany UserActions

	onGetCurrent: ->
		request
			.get '/user'
			.use authorize
			.end (res) =>
				if res.ok
					@trigger res.body.user

	onEdit: ->
		# TODO: Edit request

	onCreate: (email, password) ->
		request
			.post '/user'
			.use prefix
			.send {email, password}
			.end (res) =>
				if res.ok
					@trigger res.body

	onAddPoints: ->
		# TODO: Add points request

	onChangePassword: ->
		request
			.patch '/user'
			.use authorize
			.end (res) ->
				if res.ok
					@trigger res.body

module.exports = UserStore