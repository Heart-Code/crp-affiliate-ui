Reflux = require 'reflux'
{request, authorize, prefix} = require '../utils/Request'
AffiliateActions = require '../actions/AffiliateActions'

AffiliateListStore = Reflux.createStore
	init: ->
		@list = []
		@listenToMany AffiliateActions
		AffiliateActions.loadAll()
	onLoadAll: ->
		request
			.get "/affiliates/"
			.use authorize
			.end (res) =>
				if res.ok
					@list = res.body
					@trigger @list

module.exports = AffiliateListStore