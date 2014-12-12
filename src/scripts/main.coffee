React = require 'react'
{Routes, Route, DefaultRoute, NotFoundRoute, Link} = require('react-router')

# Pages
MainPage = React.createFactory require './pages/MainPage'
Login = React.createFactory require './pages/Login'
SignUp = React.createFactory require './pages/SignUp'
NotFound = React.createFactory require './pages/NotFound'

# Components
Dashboard = React.createFactory require './components/Dashboard'
RewardList = React.createFactory require './components/RewardList'
AffiliateList = React.createFactory require './components/AffiliateList'
AddPoints = React.createFactory require './components/AddPoints'
Receipt = React.createFactory require './components/Receipt'
ReceiptList = React.createFactory require './components/ReceiptList'
EditProfile = React.createFactory require './components/EditProfile'
ChangePassword = React.createFactory require './components/ChangePassword'


React.initializeTouchEvents(true)

routes =
	Routes {},
		Route handler: MainPage,
			DefaultRoute handler: AffiliateList, title: 'Affiliates'
			Route path: 'rewards', handler: RewardList, title: 'Rewards'
			Route path: 'rewards/:affiliateId', name: 'rewards', handler: RewardList, title: 'Rewards'
			Route path: 'addpoints', handler: AddPoints, title: 'Add Points'
			Route path: 'changepassword', handler: ChangePassword, title: 'Change Password'			
			Route path: 'editprofile', handler: EditProfile, title: 'Edit Profile'
			Route path: 'receipts', handler: ReceiptList, title: 'Receipts'
			Route path: 'receipt/:receiptId', handler: Receipt, title: 'Receipt'
		Route path: 'login', name: 'login', handler: Login, title: 'Login'
		Route path: 'signup', name: 'signup', handler: SignUp, title: 'Sign Up'
		NotFoundRoute handler: NotFound

React.render routes, document.body
