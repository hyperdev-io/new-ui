_           = require 'lodash'
{ connect }        = require 'react-redux'

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  title: instance?.name
  instance: instance
  isLoading: not instance?

mapDispatchToProps = (dispatch) ->
    onStopInstance: -> console.log 'stopInstance'

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../InstanceDetailPage.cjsx'
