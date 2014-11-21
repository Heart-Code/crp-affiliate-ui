React = require 'react'
Reflux = require 'reflux'

{Link} = require 'react-router'
LoginActions = require '../actions/LoginActions'

ProfileAside = React.createClass
	mixins: [Reflux.ListenerMixin]
	getInitialState: ->
		profile:
			email: 'erid14@gmail.com'
			name:
				full: 'Elías Baldioceda'
			points: 125
	componentDidMount: ->
		#@listenTo LoginStore, @onLoginChange
		#
	handleLogOut: ->
		LoginActions.logout()
	render: ->
		profile = @state.profile

		<div className="crp-profile-aside small-11 center">
			<div className="crp-profile-picture">
				<img src={profile.picture ? 'img/profile_default.jpg'} />
			</div>
			<div className="crp-profile-fullname">{profile.name.full}</div>
			<div className="crp-profile-points">{profile.points} crpoints</div>
			<ul className="off-canvas-list">
				<li><a href="#"><i className="glyphicons gift"></i>Rewards Exchanged</a></li>
				<li><a href="#"><i className="glyphicons user"></i>Edit Profile</a></li>
				<li><a href="#" onClick={@handleLogOut}><i className="glyphicons lock"></i> Log Out</a></li>
			</ul>
		</div>

module.exports = ProfileAside