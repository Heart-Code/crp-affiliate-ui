React = require 'react/addons'
Reflux = require 'reflux'
{div, input, label, a} = React.DOM
{Link, Navigation} = require 'react-router'

EditProfile = React.createClass
	mixins: [Navigation]
	tansitionChangePassw: ->
		@transitionTo 'changepassword'
	render: ->

		profile = @props.user

		if not profile? then return <div>Loading...</div>

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
				<input type='text' className='search-string' value={profile.name.full}/>
			</div>
			<div>
				<label>LAST NAME: </label>
				<input type='text' className='search-string' value={profile.name.full}/>
			</div>
			<div className="small-12">
				<a className="button small-12" onClick={@tansitionChangePassw}>EDIT PROFILE</a>
			</div>
			<div className="small-12">
				<a className="button small-12" onClick={@handleSubmit}>CHANGE PASSWORD</a>
			</div>
		</div>
module.exports = EditProfile