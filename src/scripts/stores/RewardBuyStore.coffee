Reflux = require 'reflux'
Lazy = require 'lazy.js'
{request, authorize, prefix} = require '../utils/Request'
RewardActions = require '../actions/RewardActions'

RewardBuyStore = Reflux.createStore
	init: ->
		@listenToMany RewardActions
	onBuy: (id) ->
		console.log id
		request
			.post "/reward/#{id}/buy"
			.use authorize
			.end (res) =>
				if res.ok
					@trigger res.body.receipt

module.exports = RewardBuyStore