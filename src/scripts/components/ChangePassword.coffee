React = require 'react/addons'
Reflux = require 'reflux'
{div, input, label, a, p} = React.DOM
{Link, Navigation} = require 'react-router'
UserActions = require '../actions/UserActions'
PasswordStore = require '../stores/PasswordStore'

{LoggedInMixin} = require '../mixins/SessionMixins'

ValidationError =
	IncorrectPassword: 1

ChangePassword = React.createClass
	mixins: [Navigation, Reflux.listenTo(PasswordStore,'onPasswordChange')]
	getInitialState: ->
		error: 0
	isFormValid: ->
		@state.oldPasswordValid and @state.newPasswordValid and @state.isCPasswordValid
	oldPasswordOnChange: (e) ->
		oldPassword = e.target.value
		@setState oldPasswordValid: oldPassword isnt ''
	passwordOnChange: (e) ->
		newPassword = e.target.value
		@setState newPasswordValid: newPassword isnt ''
	cPasswordOnChange: (e) ->
		confirmPassword = e.target.value
		@setState isCPasswordValid: confirmPassword isnt '' and @refs.newPassword.getDOMNode().value is confirmPassword
	handleSubmit: ->
		if @isFormValid()
			# Getting all he DOM Refs
			oldPassword = @refs.oldPassword.getDOMNode().value
			newPassword = @refs.newPassword.getDOMNode().value

			UserActions.changePassword oldPassword, newPassword
	onPasswordChange: (res) ->
		if res.errors?.oldPassword?
			@setState error: ValidationError.IncorrectPassword
		else
			@transitionTo 'login'
	render: ->
		cx = React.addons.classSet

		oldPasswordClasses = cx 'red-border': @state.oldPasswordValid is false
		newPasswordClasses = cx 'red-border': @state.newPasswordValid is false
		cPasswordClasses = cx 'red-border': @state.isCPasswordValid is false
		signUpBtnClasses = cx 'invalid-button': !@isFormValid()

		if @state.error is ValidationError.IncorrectPassword
			errorMessage = p className: 'crp-alert-error', 'Incorrect password.'

		div className: 'crp-change-password',
			div className: 'columns content',	
				div className: 'crp-icon-addon big',       
					input type: 'password', placeholder: 'Old Password', ref: 'oldPassword', onChange: @oldPasswordOnChange, className: oldPasswordClasses
					label className: 'glyphicons keys',
				div className: 'crp-icon-addon big',     
					input type: 'password', ref: 'newPassword', placeholder: 'New Password', onChange: @passwordOnChange, className: newPasswordClasses
					label className: 'glyphicons keys', 
				div className: 'crp-icon-addon big',     
					input type: 'password', ref: 'confirmPassword', placeholder: 'Confirm Password', onChange: @cPasswordOnChange, className: cPasswordClasses
					label className: 'glyphicons keys',
				errorMessage
				div className: 'small-12',
					a className: 'button small-12 ' + signUpBtnClasses, onClick: @handleSubmit, 'CHANGE PASSWORD'
module.exports = ChangePassword