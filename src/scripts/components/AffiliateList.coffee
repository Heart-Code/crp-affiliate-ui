React = require 'react'
request = require 'superagent'
Lazy = require 'lazy.js'

{div, label, input, ul, li, img, span, p} = React.DOM

RewardList = React.createClass
	getInitialState: ->
		searchString: ''
		affiliates: [
			{ name: 'Taco Bell', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'taco_bell.jpg' }
			{ name: 'Adidas', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'adidas.jpg' }
			{ name: 'Orlando', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'orlando.jpg' }
		]
	componentDidMount: ->
		###
		request
			.get 'http://api.crp.eridlabs.com/rewards'
			.end (res) =>
				@setState rewards: res.body
		###
	handleChange: (e) ->
		@setState searchString: e.target.value
	render: ->
		affiliates = @state.affiliates
		searchString = @state.searchString.trim().toLowerCase()

		if searchString.length > 0
			affiliates = Lazy(affiliates).filter (a) -> a.name.toLowerCase().match searchString
			affiliates = affiliates.toArray()

		div className: 'crp-affiliates',
			div className: 'row collapse',
				div className: 'small-3 columns',
					label className: 'prefix', htmlFor: 'search-string', 'Search'
				div className: 'small-9 columns',
					input type: 'text', id: 'search-string', value: @state.searchString, onChange: @handleChange
			ul className: 'crp-affiliates-list', affiliates.map (affiliate) ->
				li className: 'crp-affiliates-item',
					img src: "/img/#{affiliate.img}"
					div className: 'crp-container',
						p className: 'crp-affiliate-name', affiliate.name
						p className: 'crp-affiliate-description', affiliate.description

module.exports = RewardList