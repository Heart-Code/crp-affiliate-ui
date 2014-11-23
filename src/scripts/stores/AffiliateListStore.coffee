Reflux = require 'reflux'
AffiliateActions = require '../actions/AffiliateActions'

AffiliateListStore = Reflux.createStore
	init: ->
		@list = []
		@listenToMany AffiliateActions
		AffiliateActions.loadAll()
	onLoadAll: ->
		# TODO: Get from API
		@list = [
			{ _id: '1', name: 'Taco Bell', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'taco_bell.jpg' }
			{ _id: '2', name: 'Adidas', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'adidas.jpg' }
			{ _id: '3', name: 'Orlando', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'orlando.jpg' }
			{ _id: '4', name: 'Taco Bell', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'taco_bell.jpg' }
		]

		@trigger @list

module.exports = AffiliateListStore