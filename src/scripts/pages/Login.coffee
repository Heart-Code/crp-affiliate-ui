React = require 'react'
Reflux = require 'reflux'
{div, form, input, a, i, img, nav, section, label, hr, p, span} = React.DOM
{Link} = require 'react-router'
LoginActions = require '../actions/SessionActions'
SessionStore = require '../stores/SessionStore'
{LoggedOutMixin} = require '../mixins/SessionMixins'

# TODO: Redirect if we have the token already
Login = React.createClass
	mixins: [Reflux.ListenerMixin, LoggedOutMixin]
	getInitialState: ->
		status: 0
	onLoginChange: (status) ->
		if status is 200
			@transitionTo '/'
		else
			@setState {status}
	componentDidMount: ->
		@listenTo SessionStore, @onLoginChange
	handleSubmit: ->
		email = @refs.email.getDOMNode().value
		password = @refs.password.getDOMNode().value
		LoginActions.login email, password
	render: ->
		errorMessage = null
		if @state.status is 403
			errorMessage = p className: 'crp-error-message small-11 center', span className: 'alert-box alert round', 'Invalid credentials.'

		div className: 'crp-login row',
			nav className: 'tab-bar',
				section className: 'middle tab-bar-section',
					@props.title
			div className: 'crp-panel small-11',
				img className: 'crp-logo', src: 'img/crp_logo_full.png'
				# We could add Google and Facebook login options here
				div className: 'row-12 columns crp-login-inputs',
					div className: 'crp-icon-addon big',
						input type: 'text', placeholder: 'Email Address', id: 'email', ref: 'email'
						label htmlFor: 'email', className: 'glyphicons envelope'
					div className: 'crp-icon-addon big',
						input type: 'password', placeholder: 'Password', id: 'password', ref: 'password'
						label htmlFor: 'password', className: 'glyphicons keys'
				errorMessage
				div className: 'small-12 columns',
					a className: 'button small-12', onClick: @handleSubmit,
						'LOGIN'
				hr()
				p className: 'crp-description',
					'Not a member? '
					Link to: 'signup', 'Sign up'

module.exports = Login