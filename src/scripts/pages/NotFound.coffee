React = require 'react'

{div} = React.DOM

NotFound = React.createClass
	render: ->
		div className: 'not-found',
			'Not found!'

module.exports = NotFound