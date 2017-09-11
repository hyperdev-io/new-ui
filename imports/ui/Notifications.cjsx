React           = require 'react'
Notifications   = require 'react-notification-system-redux'
{ connect }     = require 'react-redux'

style =
  NotificationItem:
    DefaultStyle:
      margin: '10px 5px 2px 1px'

notificationsComponent  = ({notifications}) ->
  <Notifications notifications={notifications} style={style} />

mapStateToProps = (state) ->
  notifications: state.notifications

module.exports = connect(mapStateToProps) notificationsComponent
