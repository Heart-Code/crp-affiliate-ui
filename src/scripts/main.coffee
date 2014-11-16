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


AffiliateStoreAction = require './actions/AffiliateStoreActions'
AffiliateStoreAction.loadAffiliates [
	{ name: 'Taco Bell', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'taco_bell.jpg' }
	{ name: 'Adidas', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'adidas.jpg' }
	{ name: 'Orlando', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', img: 'orlando.jpg' }
]

routes =
	Routes null,
		Route handler: MainPage,
			DefaultRoute handler: AffiliateList, title: 'Affiliates'
			Route path: 'rewards', handler: RewardList, title: 'Rewards'
		Route path: 'login', name: 'login', handler: Login, title: 'Login'
		Route path: 'signup', name: 'signup', handler: SignUp, title: 'Sign Up'
		NotFoundRoute handler: NotFound

React.render routes, document.body