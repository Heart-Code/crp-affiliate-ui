React = require 'react/addons'
Reflux = require 'reflux'
TopMenu = require '../components/TopMenu'
BottomMenu = require '../components/BottomMenu'

UserActions = require '../actions/UserActions'
SessionActions = require '../actions/SessionActions'
UserStore = require '../stores/UserStore'
SessionStore = require '../stores/SessionStore'

{div} = React.DOM

MainPage = React.createClass
	mixins: [Reflux.connect(UserStore, 'user'), Reflux.listenTo(SessionStore, 'onSessionChange')]
	getInitialState: ->
		title: 'N/A'	# TODO: Use TitleStore or something like that so we can change the title anywhere
		displayMenu: false
		user: undefined
	componentWillMount: ->
		@setState title: @props.activeRouteHandler().props.title
	componentWillReceiveProps: (nextProps) ->
		@setState title: nextProps.activeRouteHandler().props.title	
	componentDidMount: ->
		UserActions.getCurrent()
	onSessionChange: (status) ->
		# If we get a forbidden or unauthorized acces to the user's own data then something's wrong with the access token
		if status in [401, 403] # TODO: Use constants
			SessionActions.logout()
	onToggleMenu: ->
		@setState displayMenu: !@state.displayMenu
	render: ->
		cx = React.addons.classSet
		classes = cx
			'move-left': @state.displayMenu
		console.log 'rendered'

		div className: "main-page off-canvas-wrap #{classes}",
			div className: 'inner-wrap',
				TopMenu title: @state.title, user: @state.user, onToggleMenu: @onToggleMenu
				@props.activeRouteHandler user: @state.user
				BottomMenu()

module.exports = MainPage