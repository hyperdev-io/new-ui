{ createContainer } = require 'meteor/react-meteor-data'

module.exports = createContainer (props) ->
  App = props.route.App
  query = props.location.query
  StorageBuckets = App.collections.StorageBuckets

  console.log props

  App.subscribe.allApps()
  App.subscribe.allStorageBuckets()

  selectedAppName = props.params?.name or null
  selectedAppVersion = props.params?.version or null

  apps: (App.collections.Apps.find({}, sort: {name: -1, version: -1}).map (a) -> _id: a._id, name: a.name, version: a.version) or []
  buckets: StorageBuckets.find({}, sort: name: 1).map (b) -> b.name
  name: query?.name
  bucket: query?.bucket
  appsearch: query?.appsearch
  selectedApp: App.collections.Apps.findOne name: selectedAppName, version: selectedAppVersion
  selectedAppName: props.params?.name or null
  selectedAppVersion: props.params?.version or null
  onAppSelected: (name, version) ->
    App.emit 'NewInstancePage::state changed', name, version, {}
  onStateChanged: (state) ->
    App.emit 'NewInstancePage::state changed', selectedAppName, selectedAppVersion, state

, require '../NewInstancePage.cjsx'
