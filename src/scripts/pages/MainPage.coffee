React = require 'react'
TopMenu = require '../components/TopMenu'

{div} = React.DOM

# TODO: Redirect to login if not logged-in
MainPage = React.createClass
	render: ->
		div className: 'main-page',
			TopMenu(),
			@props.activeRouteHandler()

module.exports = MainPage