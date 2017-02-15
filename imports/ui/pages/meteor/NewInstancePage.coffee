{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App

  selectedAppName = props.params?.name
  selectedAppVersion = props.params?.version

  App.subscribe.allApps()

  apps: (App.collections.Apps.find({}, sort: {name: -1, version: -1}).map (a) -> _id: a._id, name: a.name, version: a.version) or []
  selectedAppName: selectedAppName
  selectedAppVersion: selectedAppVersion

, require '../NewInstancePage.cjsx'
