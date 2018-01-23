{ connect }        = require 'react-redux'

mapStateToProps = (state) ->
  instances: state.collections.instances or []

module.exports = connect(mapStateToProps) require '../InstancesPage'
