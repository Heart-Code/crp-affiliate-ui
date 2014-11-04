React = require 'react'
{Link} = require 'react-router'

{div, ul, li, a} = React.DOM

TopMenu = React.createClass
	getInitialState: ->
		# TODO: Get them from the API
		items: [
			{ name: 'Home', url: '/'}
			{ name: 'Rewards', url: '/rewards'}
		]
	render: ->
		div className: 'top-menu',
			ul null, @state.items.map (i) ->
				li null,
					Link to: i.url, "#{i.name}"

module.exports = TopMenu
