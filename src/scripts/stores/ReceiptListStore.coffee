Reflux = require 'reflux'
Lazy = require 'lazy.js'
{request, authorize, prefix} = require '../utils/Request'
ReceiptActions = require '../actions/ReceiptActions'

ReceiptListStore = Reflux.createStore
	init: ->
		@receipts = []

		@listenToMany ReceiptActions

	onLoadAll: ->
		request
			.get "/receipts/"
			.use authorize
			.end (res) =>
				if res.ok
					@receipts = res.body
					@trigger @receipts

module.exports = ReceiptListStore