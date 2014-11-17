Reflux = require 'reflux'
AffiliateActions = require '../actions/AffiliateActions'

AffiliateStore = Reflux.createStore
	init: ->
		@list = []
		@listenToMany AffiliateActions
		AffiliateActions.loadAll()
	onLoadAll: ->
		# TODO: Get from API
		@list = [
			{ name: 'Taco Bell', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'taco_bell.jpg' }
			{ name: 'Adidas', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'adidas.jpg' }
			{ name: 'Orlando', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'orlando.jpg' }
			{ name: 'Taco Bell', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'taco_bell.jpg' }
		]

		@trigger @list

module.exports = AffiliateStore