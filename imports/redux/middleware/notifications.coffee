#
# Redux middleware that creates notifications based on certain actions
#

reactNotify                   = require 'react-notification-system-redux'
{ success, warning }          = reactNotify

notification = (title, message) ->
  title: title
  message: message
  position: 'tr'
  autoDismiss: 5
  # action:
  #   label: 'Thanks!'

appSavedNotification = (app) -> notification 'App successfully saved!', "App #{app.name}:#{app.version} is saved."
appRemovedNotification = (app) -> notification 'App successfully removed!', "App #{app.name}:#{app.version} is removed."

module.exports = ({ getState, dispatch }) -> (next) -> (action) ->
  console.log action.type
  switch action.type
    when 'APP_SAVED' then dispatch success appSavedNotification action.app
    when 'APP_REMOVED' then dispatch warning appRemovedNotification action.app
  next action
