React = require 'react/addons'
Reflux = require 'reflux'
{request, authorize, prefix} = require '../utils/Request'
UserActions = require '../actions/UserActions'
SessionActions = require '../actions/SessionActions'
SessionStore = require './SessionStore'
update = React.addons.update

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
					@user = res.body.user
					@user.points = Math.floor @user.points
					@trigger @user

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

	onAddPoints: (code) ->
		if not code? or code.trim() is '' then return
		request
			.post "/points/#{code}"
			.use authorize
			.end (res) =>
				if res.ok
					if res.body.errors?
						@trigger @user
					else
						# Immutability helper
						@user = update @user, points: $set: Math.floor res.body.user.points
						@trigger @user

module.exports = UserStore