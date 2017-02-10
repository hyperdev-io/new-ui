{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App

  isLoggedIn: App.state.isLoggedIn()
  userFirstname: App.state.user()?.profile?.firstname
  onLogin: (username, password) ->
    Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}

, require '../LoginPage.cjsx'
