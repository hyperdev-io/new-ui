{ connect }        = require 'react-redux'

mapStateToProps = (state) ->
  user = state.collections.user
  isLoggedIn: user?
  userFirstname: user?.profile.firstname

mapDispatchToProps = (dispatch) ->
  onLogin: (username, password) ->
    Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../LoginPage.cjsx'

# { createContainer } = require 'meteor/react-meteor-data'
#
#
# module.exports = createContainer (props) ->
#   App = props.route.App
#
#   isLoggedIn: App.state.isLoggedIn()
#   userFirstname: App.state.user()?.profile?.firstname
#   onLogin: (username, password) ->
#     Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}
#
# , require '../LoginPage.cjsx'
