{ connect }        = require 'react-redux'
{ loginRequest }   = require '/imports/redux/actions/auth.coffee'

mapStateToProps = (state) ->
  user = state.collections.user
  isLoggedIn: user?
  userFirstname: user?.profile.firstname

mapDispatchToProps = (dispatch) ->
  onLogin: (username, password) -> dispatch loginRequest username, password

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../LoginPage.cjsx'
