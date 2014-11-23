React = require 'react'
{Link} = require 'react-router'

{div, a, label, img, i} = React.DOM

BottomMenu = React.createClass
	getInitialState: ->
		# TODO: Get them from the API
		items: [
			{ name: 'Home', url: '/'}
			{ name: 'Rewards', url: '/rewards'}
		]
	render: ->
		div className: 'icon-bar two-up crp-bottom-menu',
			@state.items.map (item) ->
				Link to: item.url, className: 'item',
					i className: 'fi-home', null
					label null, "#{item.name}"

module.exports = BottomMenu
