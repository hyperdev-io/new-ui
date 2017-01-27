_ = require 'lodash'
{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Apps = App.collections.Apps

  console.log 'state', App.state.selectedAppName()

  App.subscribe.allApps()

  # console.table Apps.find().fetch()
  appNames: _.uniq (Apps.find({}, sort: name: 1).fetch().map (app) -> app.name)
  appNameSelected: (name) -> App.emit 'app name selected', name

, require '../AppsPage.cjsx'
