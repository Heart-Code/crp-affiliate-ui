React = require 'react'

{div, p, img, h2, h3, span} = React.DOM

RewardExchange = React.createClass
	getInitialState: ->
		rewardExchange:
    code: 'RET97GCRP'
    expires: '2090-12-12'
    reward:
      title: 'Chalupa Supreme'
      description: 'Deliciosa chalupa con tortilla suave, carne, guacamole y quesitooo maeee!'
    	picture: ''
    	value: 150
	render: ->
		div className: 'crp-container',
			img className: 'crp-reward-img', src: 'http://placehold.it/100x100'
			h2 className: 'crp-reward-title', @state.rewardExchange.reward.title
			p className: 'crp-reward-description', @state.rewardExchange.reward.description
			div className: 'row crp-reward-exchange text-center',
				div className: 'crp-exchange-points',
					span className: 'points', '-' + @state.rewardExchange.value + ' pts'
				h3 className: 'crp-reward-code', 'Code - ' + @state.rewardExchange.code
				p, 'Expires'
				p className: 'crp-reward-expires', @state.rewardExchange.expires
module.exports = RewardExchange