React = require 'react'
{div, nav, section, i, a} = React.DOM
{Link, Navigation} = require 'react-router'

SignUp = React.createClass
	mixins: [Navigation]
	getInitialState: ->
		emailPattern: /// ^ ([\w.-]+) @ ([\w.-]+) \. ([a-zA-Z.]{2,6}) $ ///i       
		emailIsInvalid: false
		passwordIsInvalid : false
		confirmPasswordISInvalid : false
	handleBack: ->
		@transitionTo 'login'
	emailOnChange: (e) ->
		obj = e.target
		@setState emailIsInvalid: if obj.value.match @state.emailPattern then false else true     
	handleSubmit: ->
		#getting all he DOM Refs
		email = @refs.email.getDOMNode().value
		password = @refs.password.getDOMNode().value
		confirmPassword = @refs.confirmPassword.getDOMNode().value
		#Checking if the inputs are valid
		@setState emailIsInvalid: if email == '' then true else if email.match @state.emailPattern then false else true
		@setState passwordIsInvalid: if password == '' then true else false
		@setState confirmPasswordISInvalid: if confirmPassword == '' then true else false

	render: ->

		#Checking the state of the input, to add the redborder class
		emailValid = if @state.emailIsInvalid then 'redBorder' else ''
		passValid = if @state.passwordIsInvalid then 'redBorder' else ''
		confpassValid = if @state.confirmPasswordISInvalid then 'redBorder' else ''

		<div className="crp-sign-up">
			<nav className="tab-bar">
				<section className="tab-bar-section">
					<a href="#" onClick={@handleBack}>&lt; Back</a>
				</section>
				<section className="middle tab-bar-section">{@props.title}</section>
			</nav>
			<div className="columns content">
				<div className="crp-icon-addon big">          
					<input type="text" placeholder="Email Address" ref="email" onChange={@emailOnChange} className={emailValid}/>
					<label className="glyphicons envelope"></label>
				</div>
				<div className="crp-icon-addon big">     
					<input type="password" ref="password" placeholder="Password" className={passValid}/>
					<label className="glyphicons keys"></label>     
				</div>
				<div className="crp-icon-addon big">     
					<input type="password" ref="confirmPassword" placeholder="Confirm Password" className={confpassValid}/>
					<label className="glyphicons keys"></label>
				</div>
				<div className="small-12">
					<a className="button small-12" onClick={@handleSubmit}>SIGN UP</a>
				</div>
				<hr />
			</div>
		</div>

module.exports = SignUp