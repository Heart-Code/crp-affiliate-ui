React = require 'react'

ProfileAside = React.createClass
	getInitialState: ->
		profile: {}

	init: ->
		profile = @props.profile

		<div class="crp-profile-aside">
			<div class="crp-profile-picture">
				<img src={profile.picture ? 'img/profile_default.png'} />
			</div>
		</div>

module.exports = ProfileAside