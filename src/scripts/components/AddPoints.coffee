React = require 'react'

{div, input, span, a} = React.DOM

AddPoints = React.createClass
	render: ->
			div className: 'crp-search',
				div className: 'crp-points',
					span className: 'points', '20pts'
				input type: 'text', id: 'search-string', placeholder: 'Add Points'
				a className: 'button small-12', 'AddPoints'
				


module.exports = AddPoints
