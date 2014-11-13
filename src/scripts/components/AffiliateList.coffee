React = require 'react'
request = require 'superagent'
Lazy = require 'lazy.js'

{div, label, input, ul, li, img, span, p} = React.DOM

RewardList = React.createClass
	getInitialState: ->
		searchString: ''
		affiliates: [
			{ name: 'Taco Bell', description: 'asdf', img: 'taco_bell.jpg' }
			{ name: 'Adidas', description: 'asdf', img: 'adidas.jpg' }
			{ name: 'Orlando', description: 'asdf', img: 'orlando.jpg' }
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
			label htmlFor: 'search-string', 'Search'
			input type: 'text', id: 'search-string', value: @state.searchString, onChange: @handleChange
			ul className: 'crp-affiliates-list', affiliates.map (affiliate) ->
				li className: 'crp-affiliates-item',
					img src: "/img/#{affiliate.img}"
					div className: 'crp-container',
						p null, affiliate.name
						p null, affiliate.description

module.exports = RewardList