React = require 'react'

{h1} = React.DOM

Dashboard = React.createClass
	# TODO: Create components and load them here
	render: ->
		h1 null, 'Home :)!'

module.exports = Dashboard