AppDispatcher = require '../dispatcher/AppDispatcher'
AffiliateStoreConstants = require '../constants/AffiliateConstants'

AffiliateStoreActions =
	loadAffiliates: (data) ->
		AppDispatcher.handleAction
			actionType: AffiliateStoreConstants.LOAD_AFFILIATES
			data: data

module.exports = AffiliateStoreActions