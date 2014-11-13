React = require 'react'
{Routes, Route, DefaultRoute, NotFoundRoute, Link} = require('react-router')

# Pages
MainPage = require './pages/MainPage'
Login = require './pages/Login'
NotFound = require './pages/NotFound'

# Components
Dashboard = require './components/Dashboard'
RewardList = require './components/RewardList'
AffiliateList = require './components/AffiliateList'

routes =
	Routes null,
		Route handler: MainPage,
			DefaultRoute handler: AffiliateList
			Route path: 'rewards', handler: RewardList
		Route path: 'login', handler: Login
		NotFoundRoute handler: NotFound

React.render routes, document.body