React = require 'react/addons'
TopMenu = require '../components/TopMenu'
BottomMenu = require '../components/BottomMenu'

{div} = React.DOM

# TODO: Redirect to login if not logged-in
MainPage = React.createClass
	getInitialState: ->
		title: 'N/A'
		displayMenu: false
	componentWillMount: ->
		@setState title: @props.activeRouteHandler().props.title
	componentWillReceiveProps: (nextProps) ->
		@setState title: nextProps.activeRouteHandler().props.title
	onToggleMenu: ->
		@setState displayMenu: !@state.displayMenu
	render: ->
		cx = React.addons.classSet
		classes = cx
			'move-left': @state.displayMenu

		div className: "main-page off-canvas-wrap #{classes}",
			div className: 'inner-wrap',
				TopMenu title: @state.title, onToggleMenu: @onToggleMenu
				@props.activeRouteHandler()
				BottomMenu()

module.exports = MainPage