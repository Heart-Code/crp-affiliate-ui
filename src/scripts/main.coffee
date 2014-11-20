React = require 'react'
{Routes, Route, DefaultRoute, NotFoundRoute, Link} = require('react-router')

# Pages
MainPage = require './pages/MainPage'
Login = require './pages/Login'
SignUp = require './pages/SignUp'
NotFound = require './pages/NotFound'

# Components
Dashboard = require './components/Dashboard'
RewardList = require './components/RewardList'
AffiliateList = require './components/AffiliateList'

React.initializeTouchEvents(true)

routes =
	Routes null,
		Route handler: MainPage,
			DefaultRoute handler: AffiliateList, title: 'Affiliates'
			Route path: 'rewards', handler: RewardList, title: 'Rewards'
			Route path: 'rewards/:affiliateId', name: 'rewards', handler: RewardList, title: 'Rewards'
		Route path: 'login', name: 'login', handler: Login, title: 'Login'
		Route path: 'signup', name: 'signup', handler: SignUp, title: 'Sign Up'
		NotFoundRoute handler: NotFound

React.render routes, document.body
