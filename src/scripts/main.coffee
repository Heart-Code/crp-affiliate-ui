React = require 'react'
{Routes, Route, DefaultRoute, NotFoundRoute, Link} = require('react-router')

# Pages
MainPage = require './pages/MainPage'
Login = require './pages/Login'
NotFound = require './pages/NotFound'

# Components
Dashboard = require './components/Dashboard'
RewardList = require './components/RewardList'

routes =
	Routes location: 'history',
		Route handler: MainPage,
			DefaultRoute handler: Dashboard
			Route path: 'rewards', handler: RewardList
		Route path: 'login', handler: Login
		NotFoundRoute handler: NotFound

React.render routes, document.body