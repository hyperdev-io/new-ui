_           = require 'lodash'
{ connect } = require 'react-redux'
{ stopInstanceRequest } = require '/imports/redux/actions/instance.coffee'

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  title: instance?.name
  instance: instance
  isLoading: not instance?

mapDispatchToProps = (dispatch) ->
  onStopInstance: (instanceName) -> dispatch stopInstanceRequest instanceName

mergeProps = (stateProps, dispatchProps, ownProps) ->
  Object.assign {}, stateProps, dispatchProps, ownProps,
    onStopInstance: -> dispatchProps.onStopInstance stateProps.instance.name

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../InstanceDetailPage.cjsx'
