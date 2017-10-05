_           = require 'lodash'
{ connect } = require 'react-redux'
md5         = require 'md5'
{ stopInstanceRequest } = require '/imports/redux/actions/instance.coffee'
{ appSelected } = require '/imports/redux/actions/apps.coffee'
{ openBucketPageRequest } = require '/imports/redux/actions/buckets.coffee'
{ goToInstanceDetailsPage } = require '/imports/redux/actions/navigation.coffee'

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  startByUser = _.find state.collections.users, {_id: instance?.startedBy}
  title: instance?.name
  instance: instance
  notFound: not instance?
  showLogs: params.type is 'logs'
  service: params.service
  log: state.collections.log
  startedBy:
    fullname: "#{startByUser?.profile?.firstname} #{startByUser?.profile?.lastname}"
    email: startByUser?.profile?.email
    gravatar: "http://www.gravatar.com/avatar/#{md5(startByUser?.profile?.email)}" if startByUser?.profile?.email?


mapDispatchToProps = (dispatch) ->
  onStopInstance: (instanceName) -> dispatch stopInstanceRequest instanceName
  onOpenAppPage: (name, version)-> dispatch appSelected name, version
  onOpenBucketPage: (name) -> dispatch openBucketPageRequest name
  onLogClose: (name) -> dispatch goToInstanceDetailsPage name

mergeProps = (stateProps, dispatchProps, ownProps) ->
  Object.assign {}, stateProps, dispatchProps, ownProps,
    onStopInstance: -> dispatchProps.onStopInstance stateProps.instance.name
    onOpenAppPage: -> dispatchProps.onOpenAppPage stateProps.instance?.app?.name, stateProps.instance?.app?.version
    onOpenBucketPage: -> dispatchProps.onOpenBucketPage stateProps.instance?.storageBucket
    onLogClose: -> dispatchProps.onLogClose stateProps.instance.name

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../InstanceDetailPage.cjsx'
