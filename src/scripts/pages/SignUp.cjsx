React = require 'react/addons'
Reflux = require 'reflux'
{div, nav, section, i, a} = React.DOM
{Link, Navigation} = require 'react-router'
UserActions = require '../actions/UserActions'
UserStore = require '../stores/UserStore'

ValidationError =
	RepeatedEmail: 1

SignUp = React.createClass
	mixins: [Navigation, Reflux.listenTo(UserStore,'onUserChange')]
	getInitialState: ->
		error: 0
	isFormValid: ->
		@state.isEmailValid and @state.isPasswordValid and @state.isCPasswordValid
	handleBack: ->
		@transitionTo 'login'
	emailOnChange: (e) ->
		email = e.target.value
		@setState isEmailValid: email isnt '' and !!email.match /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
	passwordOnChange: (e) ->
		password = e.target.value
		@setState isPasswordValid: password isnt ''
	cPasswordOnChange: (e) ->
		confirmPassword = e.target.value
		@setState isCPasswordValid: confirmPassword isnt '' and @refs.password.getDOMNode().value is confirmPassword
	handleSubmit: ->
		if @isFormValid()
			# Getting all he DOM Refs
			email = @refs.email.getDOMNode().value
			password = @refs.password.getDOMNode().value

			UserActions.create email, password
	onUserChange: (res) ->
		console.log res
		if res.errors?.email?
			@setState error: ValidationError.RepeatedEmail
		else
			@transitionTo 'login'
	render: ->
		cx = React.addons.classSet

		# Checking the state of the inputs to define the classes of the form elements
		emailClasses = cx 'red-border': @state.isEmailValid is false
		passwordClasses = cx 'red-border': @state.isPasswordValid is false
		cPasswordClasses = cx 'red-border': @state.isCPasswordValid is false
		signUpBtnClasses = cx 'invalid-button': !@isFormValid()

		if @state.error is ValidationError.RepeatedEmail
			errorMessage = <p className="crp-alert-error">The email you are trying to register is already in use.</p>

		<div className="crp-sign-up">
			<nav className="tab-bar">
				<section className="tab-bar-section">
					<a href="#" onClick={@handleBack}>&lt; Back</a>
				</section>
				<section className="middle tab-bar-section">{@props.title}</section>
			</nav>
			<div className="columns content">
				<div className="crp-icon-addon big">          
					<input type="text" placeholder="Email Address" id="email" ref="email" className={emailClasses} onChange={@emailOnChange} />
					<label className="glyphicons envelope"></label>
				</div>
				<div className="crp-icon-addon big">     
					<input type="password" ref="password" placeholder="Password" className={passwordClasses} onChange={@passwordOnChange} />
					<label className="glyphicons keys"></label>     
				</div>
				<div className="crp-icon-addon big">     
					<input type="password" placeholder="Confirm Password" className={cPasswordClasses} onChange={@cPasswordOnChange} />
					<label className="glyphicons keys"></label>
				</div>
				{errorMessage}
				<div className="small-12">
					<a className="button small-12 #{signUpBtnClasses}" onClick={@handleSubmit}>SIGN UP</a>
				</div>
				<hr />
			</div>
		</div>

module.exports = SignUp