React = require 'react'
{div} = React.DOM

Login = React.createClass
	render: ->
		div className: 'login', 'LOGIN'

module.exports = Login