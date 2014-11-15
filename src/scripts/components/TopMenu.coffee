React = require 'react'
{Link} = require 'react-router'

{div, a, label, aside, nav, section, i, span, ul, li} = React.DOM

TopMenu = React.createClass
	getInitialState: ->
		# TODO: Get them from the API
		items: [
			{ name: 'Home', url: '/'}
			{ name: 'Rewards', url: '/rewards'}
		]
	onMenuClick: ->
		@props.onToggleMenu?()
	render: ->
		div className: 'top-menu',
			nav className: 'tab-bar',
				section className: 'left-small',
					i className: 'fi-home'
				section className: 'middle tab-bar-section',
					@props.title
				section className: 'right-small',
					a className: 'right-off-canvas-toggle menu-icon', onClick: @onMenuClick, span()
			aside className: 'right-off-canvas-menu',
				ul className: 'off-canvas-list',
					@state.items.map (item) ->
						li null,
							Link to: item.url, item.name

module.exports = TopMenu
