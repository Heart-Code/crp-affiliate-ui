React = require 'react'
TopMenu = require '../components/TopMenu'
BottomMenu = require '../components/BottomMenu'

{div} = React.DOM

# TODO: Redirect to login if not logged-in
MainPage = React.createClass
	render: ->
		div className: 'main-page',
			TopMenu()
			@props.activeRouteHandler()
			BottomMenu()

module.exports = MainPage