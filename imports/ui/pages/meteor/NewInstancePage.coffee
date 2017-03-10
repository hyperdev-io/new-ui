_           = require 'lodash'
{ connect } = require 'react-redux'

mapStateToProps = (state, { params, location }) ->
  query = location.query
  selectedAppName = params.name or null
  selectedAppVersion = params.version or null
  apps: state.collections.apps?.map (a) -> _id: a._id, name: a.name, version: a.version or []
  buckets: state.collections.buckets?.map (b) -> b.name
  name: query?.name
  bucket: query?.bucket
  appsearch: query?.appsearch
  selectedApp: _.find state.collections.apps, (name: selectedAppName, version: selectedAppVersion)
  selectedAppName: selectedAppName
  selectedAppVersion: selectedAppVersion

mapDispatchToProps = (dispatch) ->
  onStateChanged: (state) ->
    dispatch Object.assign (type: 'START_APP_REQUEST'), state

mergeProps = (stateProps, dispatchProps, ownProps) ->
  state =
    app:
      name: stateProps.selectedAppName
      version: stateProps.selectedAppVersion
    params:
      name: stateProps.name
      bucket: stateProps.bucket
      appsearch: stateProps.appsearch

  Object.assign {}, stateProps, dispatchProps, ownProps,
    onStateChanged: (stateDiff) ->
      dispatchProps.onStateChanged Object.assign {}, state, params: (Object.assign {}, state.params, stateDiff)
    onAppSelected: (name, version) ->
      dispatchProps.onStateChanged Object.assign {}, state, app: {name: name, version:version}

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../NewInstancePage.cjsx'

# { createContainer } = require 'meteor/react-meteor-data'
#
# module.exports = createContainer (props) ->
#   App = props.route.App
#   query = props.location.query
#   StorageBuckets = App.collections.StorageBuckets
#
#   console.log props
#
#   App.subscribe.allApps()
#   App.subscribe.allStorageBuckets()
#
#   selectedAppName = props.params?.name or null
#   selectedAppVersion = props.params?.version or null
#
#   apps: (App.collections.Apps.find({}, sort: {name: -1, version: -1}).map (a) -> _id: a._id, name: a.name, version: a.version) or []
#   buckets: StorageBuckets.find({}, sort: name: 1).map (b) -> b.name
#   name: query?.name
#   bucket: query?.bucket
#   appsearch: query?.appsearch
#   selectedApp: App.collections.Apps.findOne name: selectedAppName, version: selectedAppVersion
#   selectedAppName: props.params?.name or null
#   selectedAppVersion: props.params?.version or null
#   onAppSelected: (name, version) ->
#     App.emit 'NewInstancePage::state changed', name, version, {}
#   onStateChanged: (state) ->
#     App.emit 'NewInstancePage::state changed', selectedAppName, selectedAppVersion, state
#
# , require '../NewInstancePage.cjsx'
