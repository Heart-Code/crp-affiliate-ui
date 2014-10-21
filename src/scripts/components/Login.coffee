{div, label, input, p} = React.DOM

Login = React.createClass
	getInitialState: ->
		username: ''
	onChangeUsername: (e) ->
		@setState username: e.target.value
	render: ->
		div className: 'login',
			label htmlFor: 'username', 'Username'
			input type: 'text', value: @state.username, onChange: @onChangeUsername
			p null, "You are trying to log as #{@state.username}"

module.exports = Login