{Dispatcher} = require 'flux'
AppDispatcher = new Dispatcher()

AppDispatcher.handleAction = (action) ->
  @dispatch
    source: 'API_ACTION'
    action: action

AppDispatcher.handleViewAction = (action) ->
  @dispatch
    source: 'VIEW_ACTION'
    action: action

module.exports = AppDispatcher