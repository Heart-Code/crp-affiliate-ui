React = require 'react'
{div, form, input, a, i, img, nav, section, label, hr, p} = React.DOM
{Link} = require 'react-router'

Login = React.createClass
	render: ->
		div className: 'crp-login row',
			nav className: 'tab-bar',
				section className: 'middle tab-bar-section',
					@props.title
			div className: 'crp-panel small-11',
				img className: 'crp-logo', src: 'img/crp_logo_full.png'
				# We could add Google and Facebook login options here
				div className: 'row-12 columns crp-login-inputs',
					div className: 'crp-icon-addon big',
						input type: 'text', placeholder: 'Email Address', id: 'email'
						label for: 'email', className: 'glyphicons envelope'
					div className: 'crp-icon-addon big',
						input type: 'text', placeholder: 'Password', id: 'password'
						label for: 'password', className: 'glyphicons keys'
				div className: 'small-12 columns',
					a className: 'button small-12',
						'LOGIN'
				hr()
				p className: 'crp-description',
					'Not a member? '
					Link to: 'signup', 'Sign up'

module.exports = Login