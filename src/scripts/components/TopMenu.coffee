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
		title: 'Affiliates'
	render: ->
		div className: 'off-canvas-wrap',
			div className: 'inner-wrap',
				nav className: 'tab-bar',
					section className: 'left-small',
						i className: 'fi-home'
					section className: 'middle tab-bar-section',
						@state.title
					section className: 'right-small',
						a className: 'right-off-canvas-toggle menu-icon', span()
				aside className: 'right-off-canvas-menu',
					ul className: 'off-canvas-list',
						@state.items.map (item) ->
							li null,
								Link to: item.url

module.exports = TopMenu
