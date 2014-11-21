React = require 'react'
{Link} = require 'react-router'

{div, a, label, aside, nav, section, i, span, ul, li, img} = React.DOM

ProfileAside = require './ProfileAside'

TopMenu = React.createClass
	onMenuClick: ->
		@props.onToggleMenu?()
	render: ->
		div className: 'top-menu',
			nav className: 'tab-bar',
				section className: 'left-small',
					img className: 'crp-logo', src: 'img/crp_logo.png'
				section className: 'middle tab-bar-section',
					@props.title
				section className: 'right-small',
					a className: 'right-off-canvas-toggle menu-icon', onClick: @onMenuClick, span()
			aside className: 'right-off-canvas-menu', ProfileAside()

module.exports = TopMenu
