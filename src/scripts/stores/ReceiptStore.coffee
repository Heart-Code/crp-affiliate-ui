Reflux = require 'reflux'
{request, authorize, prefix} = require '../utils/Request'
ReceiptActions = require '../actions/ReceiptActions'

ReceiptStore = Reflux.createStore
	init: ->
		@receipt = {}

		@listenToMany ReceiptActions

	onLoadReceipt: (receiptId) ->
		console.log receiptId
		request
			.get "/receipt/#{receiptId}"
			.use authorize
			.end (res) =>
				if res.ok
					@trigger res.body.receipt

module.exports = ReceiptStore