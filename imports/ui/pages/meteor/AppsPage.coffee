{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Apps = App.collections.Apps

  App.subscribe.allApps()

  console.table Apps.find().fetch()
  apps: Apps.find().fetch()

, require '../AppsPage.cjsx'
