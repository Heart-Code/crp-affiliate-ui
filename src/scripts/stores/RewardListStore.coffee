Reflux = require 'reflux'
Lazy = require 'lazy.js'
RewardActions = require '../actions/RewardActions'

RewardListStore = Reflux.createStore
	init: ->
		@rewards = []

		@listenToMany RewardActions
		@onLoadAll()

	onLoadAll: ->
		@rewards = [
			{ name: 'Taco Bell - Burritos', affiliate: '1', points: 10, img: 'http://placehold.it/50x50' }
			{ name: 'Taco Bell - Tacos', affiliate: '1', points: 20, img: 'http://placehold.it/50x50' }
			{ name: 'Taco Bell - Burritos', affiliate: '1', points: 5, img: 'http://placehold.it/50x50' }
			{ name: 'Taco Bell - Tacos', affiliate: '1', points: 5, img: 'http://placehold.it/50x50' }

			{ name: 'Adidas - 50V8', affiliate: '2', points: 10, img: 'http://placehold.it/50x50' }
			{ name: 'Adidas - Tacos', affiliate: '2', points: 20, img: 'http://placehold.it/50x50' }
			{ name: 'Adidas - Shirt', affiliate: '2', points: 5, img: 'http://placehold.it/50x50' }
			{ name: 'Adidas - That', affiliate: '2', points: 5, img: 'http://placehold.it/50x50' }
		]

		@trigger @rewards

	onLoadFromAffiliate: (affiliateId) ->
		rewards = Lazy(@rewards).filter (r) -> r.affiliate.match affiliateId

		@trigger rewards.toArray()

module.exports = RewardListStore