React = require 'react'
Reflux = require 'reflux'
UserActions = require '../actions/UserActions'

{div, input, span, a} = React.DOM

AddPoints = React.createClass
	getInitialState: ->
		error: false
		animatePoints: 0
		showCamera: false
		code: ''
	addPoints: ->
		code = @refs.code.getDOMNode().value
		UserActions.addPoints code
	scanPoints: ->
		#@setState showCamera: true
	shouldComponentUpdate: (nextProps, nextState) ->
		@props.user?.points != nextProps.user.points or @state.error != nextState.error or @state.animatePoints > 0
	componentDidMount: ->
		###
		Quagga.init
			inputStream:
				name: "Live"
				type: "LiveStream"
			decoder:
				readers: ["code_128_reader"]
			readyFunc: ->
				Quagga.start()

		Quagga.onDetected @onDetected
		###

	onDetected: (result) ->
		console.log result
		if true
			@setState
				code: result
				showCamera: false
	
	componentWillReceiveProps: (nextProps) ->
		if @props.user?.points != nextProps.user.points
			@setState error: false
			if not @props.user? then return
			@setState animatePoints: @props.user?.points or 0
			count = setInterval (=>
				  @setState animatePoints: @state.animatePoints + 1
				  if @state.animatePoints >= @props.user.points
				  	clearInterval count
				  	@setState animatePoints: 0
				  return
				), 50
		#else
		#	@setState error: true
	render: ->
		if not @props.user? then return null
		cx = React.addons.classSet
		classes = cx
			'camera-enabled': @state.showCamera

		if @state.error then errorMessage = div className: 'crp-alert-error', 'Invalid code'
		div className: "crp-search #{classes}",
			div className: 'container',
				div className: 'crp-points',
					span className: 'points', "#{@state.animatePoints or @props.user.points}pts"
				errorMessage
				input type: 'text', id: 'search-string', placeholder: 'Add Points', ref: 'code', value: @state.code, onChange: @handleCodeChange
				a className: 'button small-12', onClick: @addPoints, 'AddPoints'
					a className: 'button small-12', onClick: @scanPoints, 'Scan'
			div id: 'interactive', className: 'viewport'
			
module.exports = AddPoints