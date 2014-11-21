React = require 'react'
{div, nav, section, i, a} = React.DOM
{Link, Navigation} = require 'react-router'

SignUp = React.createClass
	mixins: [Navigation]
	handleBack: ->
		@transitionTo 'login'
	render: ->
		<div className="crp-sign-up">
			<nav className="tab-bar">
				<section className="tab-bar-section">
					<a href="#" onClick={@handleBack}>&lt; Back</a>
				</section>
				<section className="middle tab-bar-section">{@props.title}</section>
			</nav>
			<div className="columns content">
				<div className="crp-icon-addon big">          
					<input type="text" placeholder="Email Address" id="email" />
					<label className="glyphicons envelope"></label>
				</div>
				<div className="crp-icon-addon big">     
					<input type="text" placeholder="Password" />
					<label className="glyphicons keys"></label>     
				</div>
				<div className="crp-icon-addon big">     
					<input type="text" placeholder="Confirm Password" class="crp-icon-addon big"/>
					<label className="glyphicons keys"></label>
				</div>
				<div className="small-12">
					<a className="button small-12" href="" >SIGN UP</a>
				</div>

				<hr />
			</div>
		</div>

module.exports = SignUp