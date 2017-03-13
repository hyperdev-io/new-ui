_           = require 'lodash'
{ connect }        = require 'react-redux'

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  title: instance?.name
  instance: instance
  isLoading: not instance?

module.exports = connect(mapStateToProps) require '../InstanceDetailPage.cjsx'
