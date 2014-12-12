Reflux = require 'reflux'
Lazy = require 'lazy.js'
{request, authorize, prefix} = require '../utils/Request'
RewardActions = require '../actions/RewardActions'

RewardListStore = Reflux.createStore
	init: ->
		@rewards = []

		@listenToMany RewardActions
		@onLoadAll()

	onLoadAll: ->
		request
			.get "/rewards/"
			.use authorize
			.end (res) =>
				if res.ok
					@rewards = res.body
					@trigger @rewards

	onLoadFromAffiliate: (affiliateId) ->
		rewards = Lazy(@rewards).filter (r) -> r.affiliate.match affiliateId

		@trigger rewards.toArray()

module.exports = RewardListStore