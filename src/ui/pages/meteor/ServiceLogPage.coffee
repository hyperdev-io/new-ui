_                           = require 'lodash'
{ connect }                 = require 'react-redux'
{ goToInstanceDetailsPage } = require '/imports/redux/actions/navigation.coffee'

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  startByUser = _.find state.collections.users, {_id: instance?.startedBy}
  title: "#{params.name}.#{params.service}"
  showLogs: params.type is 'logs'
  log: state.collections.log

mapDispatchToProps = (dispatch) ->
  onLogClose: (name) -> dispatch goToInstanceDetailsPage name

mergeProps = (stateProps, dispatchProps, ownProps) ->
  Object.assign {}, stateProps, dispatchProps, ownProps,
    onLogClose: -> dispatchProps.onLogClose stateProps.instance.name

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../ServiceLogPage'
