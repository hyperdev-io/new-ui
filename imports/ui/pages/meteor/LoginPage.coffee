{ connect }        = require 'react-redux'

mapStateToProps = (state) ->
  user = state.collections.user
  isLoggedIn: user?
  userFirstname: user?.profile.firstname

mapDispatchToProps = (dispatch) ->
  onLogin: (username, password) ->
    Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../LoginPage.cjsx'
