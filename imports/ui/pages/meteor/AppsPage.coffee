_ = require 'lodash'
{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Apps = App.collections.Apps

  App.subscribe.allApps()

  console.table Apps.find().fetch()
  appNames: _.uniq (Apps.find({}, sort: name: 1).fetch().map (app) -> app.name)

, require '../AppsPage.cjsx'
