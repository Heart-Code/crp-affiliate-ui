React = require 'react'
Reflux = require 'reflux'
ReceiptStore = require '../stores/ReceiptStore'
ReceiptActions = require '../actions/ReceiptActions'
{LoggedInMixin} = require '../mixins/SessionMixins'

{div, p, img, h2, h3, span} = React.DOM

Receipt = React.createClass
	mixins: [Reflux.ListenerMixin, LoggedInMixin]
	getInitialState: ->
		receipt: undefined
	onGetReceipt: (receipt) ->
		@setState {receipt}
	componentDidMount: ->
		@listenTo ReceiptStore, @onGetReceipt
		ReceiptActions.loadReceipt @props.params.receiptId
	render: ->
		if not @state.receipt? then return null
		div className: 'crp-container',
			img className: 'crp-reward-img', src: @state.receipt.reward.picture
			h2 className: 'crp-reward-title', @state.receipt.reward.name
			p className: 'crp-reward-description', @state.receipt.reward.description
			div className: 'row crp-reward-exchange text-center',
				div className: 'crp-exchange-points',
					span className: 'points', '-' + @state.receipt.reward.value + ' pts'
				h3 className: 'crp-reward-code', 'Code - ' + @state.receipt.code
				p, 'Expires'
				p className: 'crp-reward-expires', @state.receipt.reward.expires
module.exports = Receipt