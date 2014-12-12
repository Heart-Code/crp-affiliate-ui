React = require 'react'
Reflux = require 'reflux'
Lazy = require 'lazy.js'
{Navigation} = require 'react-router'
AffiliateListStore = require '../stores/AffiliateListStore'
{LoggedInMixin} = require '../mixins/SessionMixins'

{div, label, input, ul, li, img, span, p} = React.DOM

AffiliateItem = React.createClass
	mixins: [Navigation]
	shouldComponentUpdate: (nextProps, nextState) ->
		nextProps.affiliate isnt @props.affiliate # Make sure to render only if there's been changes
	handleClick: (e) ->
		@transitionTo 'rewards', affiliateId: @props.affiliate._id
	render: ->
		affiliate = @props.affiliate

		li className: 'crp-affiliates-item', onClick: @handleClick,
			div className: 'crp-icon-next big',
				img src: "#{affiliate.picture}"
				div className: 'glyphicons chevron-right'
			div className: 'crp-container',
				p className: 'crp-affiliate-name', affiliate.name
				p className: 'crp-affiliate-description', affiliate.description

AffiliateList = React.createClass
	mixins: [Reflux.ListenerMixin, LoggedInMixin]
	shouldComponentUpdate: (nextProps, nextState) ->
		nextState.searchString isnt @state.searchString or nextState.affiliates isnt @state.affiliates # Trying to improve performance on mobile =/
	getInitialState: ->
		searchString: ''
		affiliates: AffiliateListStore.list
	onAffiliateListChange: (list) ->
		@setState	affiliates: list
	componentDidMount: ->
		@listenTo AffiliateListStore, @onAffiliateListChange
	handleSearchString: (e) ->
		@setState searchString: e.target.value
	handleClickAffiliate: (e) ->
		console.log e
	render: ->
		searchString = @state.searchString.trim().toLowerCase()
		affiliates = @state.affiliates

		if searchString.length > 0
			affiliates = Lazy(affiliates).filter (a) -> a.name.toLowerCase().match searchString
			affiliates = affiliates.toArray()

		div className: 'crp-affiliates',
			div className: 'crp-search',
				input type: 'text', id: 'search-string', placeholder: '\uD83D\uDD0D Filter affiliates', value: @state.searchString, onChange: @handleSearchString
			ul className: 'crp-affiliates-list', affiliates.map (affiliate, i) -> AffiliateItem {affiliate, key: "aff-#{i}"}

module.exports = AffiliateList