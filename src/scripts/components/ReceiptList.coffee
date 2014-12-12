React = require 'react'
Reflux = require 'reflux'
request = require 'superagent'
Lazy = require 'lazy.js'
ReceiptListStore = require '../stores/ReceiptListStore'
ReceiptActions = require '../actions/ReceiptActions'

{div, label, input, ul, li, img, span, a} = React.DOM

RewardList = React.createClass
	mixins: [Reflux.ListenerMixin]
	getInitialState: ->
		searchString: ''
		receipts: []
	onReceiptListChange: (receipts) ->
		@setState {receipts}
	componentDidMount: ->
		@listenTo ReceiptListStore, @onReceiptListChange
	handleChange: (e) ->
		@setState searchString: e.target.value
	render: ->
		receipts = @state.receipts
		searchString = @state.searchString.trim().toLowerCase()

		if searchString.length > 0
			receipts = Lazy(receipts).filter (r) -> r.name.toLowerCase().match searchString
			receipts = receipts.toArray()

		div className: 'receipts',
			div className: 'crp-search',
				input type: 'text', id: 'search-string', placeholder: 'Search Receipts', value: @state.searchString, onChange: @handleChange
				span className: 'promotional', 'Bought rewards'
			ul null, receipts.map (r) ->
				li {},
					img src: r.reward.img
					span className: "name", r.reward.name
						a className: 'button', 'View'

module.exports = RewardList