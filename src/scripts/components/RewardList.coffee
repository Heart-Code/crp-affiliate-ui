React = require 'react'
request = require 'superagent'
Lazy = require 'lazy.js'

{div, label, input, ul, li, img, span} = React.DOM

RewardList = React.createClass
	getInitialState: ->
		searchString: ''
		rewards: []
	componentDidMount: ->
		request
			.get 'http://api.crp.eridlabs.com/rewards'
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
			div className: 'crp-search',
				input type: 'text', id: 'search-string', placeholder: 'Search Rewards', value: @state.searchString, onChange: @handleChange
				span className: 'promotional', 'Take a look to our latest Rewards'
			ul null, rewards.map (r) ->
				li null,
					img src: r.img
					" #{r.name} - #{r.points}"

module.exports = RewardList