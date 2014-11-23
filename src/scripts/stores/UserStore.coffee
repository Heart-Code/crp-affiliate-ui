Reflux = require 'reflux'
request = require 'superagent'

UserActions = require '../actions/UserActions'
SessionActions = require '../actions/SessionActions'
SessionStore = require './SessionStore'

UserStore = Reflux.createStore
	init: ->
		@user = {}

		@listenToMany UserActions

	onGetCurrent: ->
		console.log 'called'
		request
			.get 'http://localhost:3000/user'
			.set 'Authorization', "Bearer #{SessionStore.getAccessToken()}"
			.end (res) =>
				if res.unauthorized
					SessionActions.unauthorized()
				if res.ok
					@trigger res.body.user

	onEdit: ->
		# TODO: Edit request

	onCreate: ->
		# TODO: Add create post request

	onAddPoints: ->
		# TODO: Add points request

module.exports = UserStore