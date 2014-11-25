React = require 'react'

{div, input, span, a} = React.DOM

AddPoints = React.createClass
	getInitialState: ->
		points: 20
		error: 0
	addPoints: ->
		code = @refs.code.getDOMNode().value

		if code is '500'
			@setState error: 0
			max = @state.points + 10
			count = setInterval (=>
				  @setState points: @state.points + 1
				  clearInterval count if @state.points is max 
				  return
				), 250
		else 
			@setState error: 400

	render: ->
			if @state.error is 400 then errorMessage = div className: 'crp-alert-error', 'Invalid code'
			div className: 'crp-search',
				div className: 'crp-points',
					span className: 'points', "#{@state.points}pts"
				errorMessage
				input type: 'text', id: 'search-string', placeholder: 'Add Points', ref: 'code'
				a className: 'button small-12', onClick: @addPoints, 'AddPoints'
				


module.exports = AddPoints
