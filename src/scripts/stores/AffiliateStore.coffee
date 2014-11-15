AppDispatcher = require '../dispatcher/AppDispatcher'
AffiliateConstants = require '../constants/AffiliateConstants'
{EventEmitter} = require 'events'
merge = require 'react/lib/merge'

_affiliates = []

loadAffiliates = (data) ->
  _affiliates = data

AffiliateStore = merge EventEmitter.prototype,
  getAffiliates: -> _affiliates
  emitChange: -> @emit 'change'
  addChangeListener: (callback) -> @on 'change', callback
  removeChangeListener: (callback) -> @removeListener 'change', callback

AppDispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when AffiliateConstants.LOAD_AFFILIATES then loadAffiliates action.data
    else return true

  AffiliateStore.emitChange()

  return true

module.exports = AffiliateStore