React = require 'react'
{div, nav, section, i} = React.DOM
{Link} = require 'react-router'

SignUp = React.createClass
	render: ->
		div className: 'crp-sign-up',
			nav className: 'tab-bar',
				section className: 'tab-bar-section',
					Link to: 'login',
						'< Back'
				section className: 'middle tab-bar-section',
					@props.title
			'Coming soon!'

module.exports = SignUp