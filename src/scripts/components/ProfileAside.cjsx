React = require 'react'

{Link} = require 'react-router'
SessionActions = require '../actions/SessionActions'

ProfileAside = React.createClass
	shouldComponentUpdate: (nextProps, nextState) ->
		nextProps.user isnt @props.user # Make sure to render only if the user change (it may need deeper check for minor changes)
	handleLogOut: ->
		SessionActions.logout()
	render: ->
		profile = @props.user

		if not profile? then return <div>Loading...</div>

		<div className="crp-profile-aside small-11 center">
			<div className="crp-profile-picture">
				<img src={profile.avatar} />
			</div>
			<div className="crp-profile-fullname">{profile.name.full ? profile.email}</div>
			<div className="crp-profile-points">{profile.points} points</div>
			<ul className="off-canvas-list">
				<li><Link to="/addpoints"><i className="glyphicons gift"></i>Add Points</Link></li>
				<li><a href="#"><i className="glyphicons gift"></i>Rewards Exchanged</a></li>
				<li><a href="#"><i className="glyphicons user"></i>Edit Profile</a></li>
				<li><a href="#" onClick={@handleLogOut}><i className="glyphicons lock"></i> Log Out</a></li>
			</ul>
		</div>

module.exports = ProfileAside