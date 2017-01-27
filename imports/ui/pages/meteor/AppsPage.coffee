_ = require 'lodash'
{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Apps = App.collections.Apps

  App.subscribe.allApps()

  selectedAppName = App.state.selectedAppName()
  appSearchValue = App.state.appSearchValue()

  searchObj = {}
  if appSearchValue then searchObj = name: {$regex: appSearchValue, $options: 'i'}

  appNames: Apps.find(searchObj, sort: name: 1, version: 1).fetch()
  appTags: (Apps.find({name:selectedAppName}, sort: version: 1).fetch().map (app) -> app.version)
  selectedAppName: selectedAppName
  appSearchValue: appSearchValue
  appNameSelected: (name) -> App.emit 'app name selected', name
  appsSearchEntered: (value) -> App.emit 'app search entered', value

, require '../AppsPage.cjsx'
