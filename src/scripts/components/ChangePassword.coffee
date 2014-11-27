React = require 'react'
Reflux = require 'reflux'
Lazy = require 'lazy.js'
{} = React.DOM
{Navigation} = require 'react-router'
{LoggedInMixin} = require '../mixins/SessionMixins'

ChangePassword = React.createClass
	mixins: [Navigation, LoggedInMixin]
	render: ->
		div className: 'crp-sign-up',
			div className: 'columns content',
				div className: 'crp-icon-addon big',       
					input type: 'password', placeholder: 'Old Password', ref: 'oldPassword', onChange: {@oldPasswordChange}, className: {emailValid},
					label className: 'glyphicons envelope',
				div className: 'crp-icon-addon big',     
					input type: 'password', ref: 'password', placeholder: 'New Password', className: {passValid},
					label className: 'glyphicons keys', 
				div className: 'crp-icon-addon big',     
					input type: 'password', ref: 'confirmPassword', placeholder: 'Confirm Password', className: confpassValid},
					label className: 'glyphicons keys',
				div className: 'small-12',
					a className: 'button small-12' onClick: {@handleSubmit}, 'SIGN UP'