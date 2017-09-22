reactNotify                   = require 'react-notification-system-redux'
{ info, success, warning }    = reactNotify

notification = (title, message) ->
  title: title
  message: message
  position: 'tr'
  autoDismiss: 5

module.exports =
  instanceRunningNotification: (instance) ->
    success notification 'Instance has started', "Instance #{instance.name} has been successfully started."
  instanceStoppingNotification: (instance) ->
    warning notification 'Instance is stopping', "Instance #{instance.name} is stopping."
  instanceStopRequestedNotification: (instanceName) ->
    info notification 'Instance stop requested', "Instance #{instanceName} stop has been requested."
  instanceStartedNotification: (instance) ->
    success notification 'Instance is starting!', "Instance #{instance.name} is starting."
  instanceStoppedNotification: (instance) ->
    warning notification 'Instance has stopped!', "Instance #{instance.name} has been successfully stopped."

  appSavedNotification: (app) ->
    success notification 'App successfully saved!', "App #{app.name}:#{app.version} is saved."
  appRemovedNotification: (app) ->
    warning notification 'App successfully removed!', "App #{app.name}:#{app.version} is removed."
