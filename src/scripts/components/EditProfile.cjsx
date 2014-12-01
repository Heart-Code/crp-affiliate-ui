React = require 'react/addons'
Reflux = require 'reflux'
{div, input, label, a} = React.DOM
{Link, Navigation} = require 'react-router'

EditProfile = React.createClass
	mixins: [Navigation]
	handleBack: ->
		@transitionTo 'login'
	isFormValid: ->
		@state.isNameValid and @state.isLastNameValid and @state.isPhoneValid
	nameOnChange: (e) ->
		name = e.target.value
		@setState isNameValid: name isnt ''
	lastNameOnChange: (e) ->
		lastName = e.target.value
		@setState isLastNameValid: lastName isnt ''
	phoneOnChange: (e) ->
		phone = e.target.value
		@setState isPhoneValid: phone isnt ''
	handleChangePassword: ->
		@transitionTo '/changepassword'
	handleSubmit: ->
		if @isFormValid()
			console.log('yo')
	render: ->

		profile = @props.user

		if not @props.user? then return null

		cx = React.addons.classSet

		
		# Checking the state of the inputs to define the classes of the form elements
		
		<div className="crp-edit-profile center small-12 columns">
			
			<div className="crp-profile-fullname">{profile.name.full ? profile.email}</div>
			<div className="crp-profile-picture">
				<img src={profile.avatar} />
			</div>
			<div className="small-12">
				<a id='change-pic-button' className="button small-12" onClick={@handleSubmit}>CHANGE PICTURE</a>
			</div>
			<div>
				<label>NAME: </label>
				<input type='text' className='search-string' value={profile.name.first} onChange={@nameOnChange}/>
			</div>
			<div>
				<label>LAST NAME: </label>
				<input type='text' className='search-string' value={profile.name.last} onChange={@lastNameOnChange}/>
			</div>
			<div>
				<label>PHONE: </label>
				<input type='text' ref="phone" className='search-string' onChange={@phoneOnChange}/>
			</div>
			<div className="small-12">
				<a className="button small-12" onClick={@handleSubmit}>EDIT PROFILE</a>
			</div>
			<div className="small-12">
				<a className="button small-12" onClick={@handleChangePassword}>CHANGE PASSWORD</a>
			</div>

		</div>
module.exports = EditProfile