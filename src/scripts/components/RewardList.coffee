React = require 'react'
Reflux = require 'reflux'
request = require 'superagent'
Lazy = require 'lazy.js'
RewardListStore = require '../stores/RewardListStore'
RewardActions = require '../actions/RewardActions'

{div, label, input, ul, li, img, span, a} = React.DOM


RewardItem = React.createClass
	getInitialState: ->
		expand: false
		expire: '2014/12/13'

	onExpand: ->
		@setState expand: !@state.expand

	render: ->	
		r = @props.r
		cx = React.addons.classSet
		classes = cx
			'expand': @state.expand

		li className: classes,
					img src: r.img
					span className: "name", r.name
					div className: "points", "#{r.points}",
						a className: '', onClick: @onExpand, '...'
					span className: 'expire', "Expire Date: #{@state.expire}"
					span className: 'description', 'Lorem ipsum dolor sit amet, 
						consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'



RewardList = React.createClass
	mixins: [Reflux.ListenerMixin]
	getInitialState: ->
		searchString: ''
		rewards: []

	onRewardListChange: (rewards) ->
		@setState {rewards}
	componentDidMount: ->
		@listenTo RewardListStore, @onRewardListChange
		if @props.params.affiliateId
			RewardActions.loadFromAffiliate @props.params.affiliateId
		else
			RewardActions.loadAll()
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
			ul null, rewards.map (r) -> RewardItem { r }
			
			

module.exports = RewardList