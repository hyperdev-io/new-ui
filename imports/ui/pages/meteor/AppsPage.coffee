_ = require 'lodash'
{ connect }        = require 'react-redux'
{ appSearchChanged, appSelected } = require '/imports/actions.coffee'

mapStateToProps = (state) ->
  apps: state.apps
  appTags: []
  selectedAppName: null
  appSearchValue: state.app_search or ''

mapDispatchToProps = (dispatch) ->
  onAppNameSelected: (app) -> dispatch appSelected app.name, app.version
  onAppSearchEntered: (value) -> dispatch appSearchChanged value

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../AppsPage.cjsx'

# { createContainer } = require 'meteor/react-meteor-data'
#
#
# module.exports = createContainer (props) ->
#   App = props.route.App
#   Apps = App.collections.Apps
#
#   App.subscribe.allApps()
#
#   selectedAppName = App.state.selectedAppName()
#   appSearchValue = App.state.appSearchValue()
#
#   searchObj = {}
#   if appSearchValue then searchObj =
#     $or: [
#       name: {$regex: appSearchValue, $options: 'i'}
#     ,
#       version: {$regex: appSearchValue, $options: 'i'}
#     ]
#
#   apps: Apps.find(searchObj, sort: name: 1, version: 1).fetch()
#   appTags: (Apps.find({name:selectedAppName}, sort: version: 1).fetch().map (app) -> app.version)
#   selectedAppName: selectedAppName
#   appSearchValue: appSearchValue
#   onAppNameSelected: (name) -> App.emit 'app name selected', name
#   onAppSearchEntered: (value) -> App.emit 'app search entered', value
#
# , require '../AppsPage.cjsx'
