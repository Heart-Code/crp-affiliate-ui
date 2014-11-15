React = require 'react'
request = require 'superagent'
Lazy = require 'lazy.js'
AffiliateStore = require '../stores/AffiliateStore'

{div, label, input, ul, li, img, span, p} = React.DOM

AffiliateList = React.createClass
	getInitialState: ->
		searchString: ''
		affiliates: AffiliateStore.getAffiliates()
	componentDidMount: ->
		AffiliateStore.addChangeListener @_onChange
	componentWillUnmount: ->
		AffiliateStore.removeChangeListener @_onChange
	onChange: (e) ->
		@setState searchString: e.target.value
	render: ->
		searchString = @state.searchString.trim().toLowerCase()
		affiliates = @state.affiliates

		if searchString.length > 0
			affiliates = Lazy(affiliates).filter (a) -> a.name.toLowerCase().match searchString
			affiliates = affiliates.toArray()

		div className: 'crp-affiliates',
			div className: 'row collapse',
				div className: 'small-3 columns',
					label className: 'prefix', htmlFor: 'search-string', 'Search'
				div className: 'small-9 columns',
					input type: 'text', id: 'search-string', value: @state.searchString, onChange: @onChange
			ul className: 'crp-affiliates-list', affiliates.map (affiliate) ->
				li className: 'crp-affiliates-item',
					img src: "img/#{affiliate.img}"
					div className: 'crp-container',
						p className: 'crp-affiliate-name', affiliate.name
						p className: 'crp-affiliate-description', affiliate.description

	_onChange: ->
		@setState
			affiliates: AffiliateStore.getAffiliates()

module.exports = AffiliateList