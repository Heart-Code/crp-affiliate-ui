React = require 'react'
{div, form, input, a, img} = React.DOM

Login = React.createClass
	render: ->
		div className: 'crp-login',
			img className: 'crp-logo', src: 'img/crp_logo_full.png'
			div className: 'crp-panel',
				input type: 'text', placeholder: 'User name'
				input type: 'text', placeholder: 'Password'
				a className: 'button', 'LOGIN'
				a className: 'button', 'REGISTER'

module.exports = Login