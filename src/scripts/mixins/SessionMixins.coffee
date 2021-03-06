SessionStore = require '../stores/SessionStore'
{Navigation} = require 'react-router'

LoggedInMixin =
	mixins: [Navigation]
	componentWillMount: ->
		if not localStorage.getItem 'access_token'
			@transitionTo 'login'
	componentDidMount: ->
		@listenTo SessionStore, @onSessionChange

	onSessionChange: (status) ->
		if not status?
			@transitionTo 'login'

LoggedOutMixin =
	mixins: [Navigation]
	componentWillMount: ->
		if localStorage.getItem 'access_token'
			@transitionTo '/'


module.exports = {
	LoggedInMixin
	LoggedOutMixin
}