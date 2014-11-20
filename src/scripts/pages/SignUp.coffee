React = require 'react'
{div, nav, section, i, a} = React.DOM
{Link, Navigation} = require 'react-router'

SignUp = React.createClass
	mixins: [Navigation]
	handleBack: ->
		@goBack()
	render: ->
		div className: 'crp-sign-up',
			nav className: 'tab-bar',
				section className: 'tab-bar-section',
					a href: '#', onClick: @handleBack, '< Back'
				section className: 'middle tab-bar-section',
					@props.title
			'Coming soon!'

module.exports = SignUp