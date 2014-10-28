React = require 'react'
request = require 'superagent'
Lazy = require 'Lazy.js'

{div, label, input, ul, li, img} = React.DOM

Rewards = React.createClass
	getInitialState: ->
		searchString: ''
		rewards: []
	componentDidMount: ->
		request
			.get 'http://localhost:3000/rewards'
			.end (res) =>
				@setState rewards: res.body
	handleChange: (e) ->
		@setState searchString: e.target.value
	render: ->
		rewards = @state.rewards
		searchString = @state.searchString.trim().toLowerCase()

		if searchString.length > 0
			rewards = Lazy(rewards).filter (r) -> r.name.toLowerCase().match searchString
			rewards = rewards.toArray()

		div className: 'rewards',
			label htmlFor: 'search-string', 'Search'
			input type: 'text', id: 'search-string', value: @state.searchString, onChange: @handleChange
			ul null, rewards.map (r) ->
				li null,
					img src: r.img
					" #{r.name} - #{r.points}"

module.exports = Rewards