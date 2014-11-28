React = require 'react/addons'
Reflux = require 'reflux'
{div, input, label, a} = React.DOM
{Link, Navigation} = require 'react-router'
UserActions = require '../actions/UserActions'
UserStore = require '../stores/UserStore'

{LoggedInMixin} = require '../mixins/SessionMixins'

ChangePassword = React.createClass
	mixins: [Navigation, Reflux.listenTo(UserStore,'onUserChange')]
	onUserChange: (res) ->
	handleSubmit: ->
	render: ->
		div className: 'crp-sign-up',
			div className: 'columns content',	
				div className: 'crp-icon-addon big',       
					input type: 'password', placeholder: 'Old Password', ref: 'oldPassword', onChange: {@oldPasswordChange}
					label className: 'glyphicons envelope',
				div className: 'crp-icon-addon big',     
					input type: 'password', ref: 'password', placeholder: 'New Password'
					label className: 'glyphicons keys', 
				div className: 'crp-icon-addon big',     
					input type: 'password', ref: 'confirmPassword', placeholder: 'Confirm Password'
					label className: 'glyphicons keys',
				div className: 'small-12',
					a className: 'button small-12', onClick: {@handleSubmit}, 'SIGN UP'
module.exports = ChangePassword