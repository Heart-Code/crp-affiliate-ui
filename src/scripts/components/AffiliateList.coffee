React = require 'react'
Reflux = require 'reflux'
Lazy = require 'lazy.js'
{Navigation} = require 'react-router'
AffiliateStore = require '../stores/AffiliateStore'
{LoggedInMixin} = require '../mixins/SessionMixins'

{div, label, input, ul, li, img, span, p} = React.DOM

AffiliateItem = React.createClass
	mixins: [Navigation]
	handleClick: (e) ->
		@transitionTo 'rewards', affiliateId: @props.affiliate._id
		console.log this
	render: ->
		affiliate = @props.affiliate
		li className: 'crp-affiliates-item', onClick: @handleClick,
			div className: 'crp-icon-next big',
				img src: "img/#{affiliate.img}"
				div className: 'glyphicons chevron-right'
			div className: 'crp-container',
				p className: 'crp-affiliate-name', affiliate.name
				p className: 'crp-affiliate-description', affiliate.description

AffiliateList = React.createClass
	mixins: [Reflux.ListenerMixin, LoggedInMixin]
	getInitialState: ->
		searchString: ''
		affiliates: AffiliateStore.list
	onStatusChange: (list) ->
		@setState	affiliates: list
	componentDidMount: ->
		@listenTo AffiliateStore, @onStatusChange
	handleSearchString: (e) ->
		@setState searchString: e.target.value
	handleClickAffiliate: (e) ->
		console.log e
	render: ->
		searchString = @state.searchString.trim().toLowerCase()
		affiliates = @state.affiliates
		component = this

		if searchString.length > 0
			affiliates = Lazy(affiliates).filter (a) -> a.name.toLowerCase().match searchString
			affiliates = affiliates.toArray()

		div className: 'crp-affiliates',
			div className: 'crp-search',
				input type: 'text', id: 'search-string', placeholder: '\uD83D\uDD0D Filter affiliates', value: @state.searchString, onChange: @handleSearchString
			ul className: 'crp-affiliates-list', affiliates.map (affiliate) -> AffiliateItem {affiliate}

module.exports = AffiliateList