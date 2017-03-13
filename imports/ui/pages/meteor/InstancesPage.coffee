{ connect }        = require 'react-redux'

mapStateToProps = (state) ->
  instances: state.collections.instances

module.exports = connect(mapStateToProps) require '../InstancesPage.cjsx'
