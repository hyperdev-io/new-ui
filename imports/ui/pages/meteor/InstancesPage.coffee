{ connect }        = require 'react-redux'

mapStateToProps = (state) ->
  instances: state.collections.instances

module.exports = connect(mapStateToProps) require '../InstancesPage.cjsx'

# { createContainer } = require 'meteor/react-meteor-data'
#
# module.exports = createContainer (props) ->
#   App = props.route.App
#   Instances = App.collections.Instances
#
#   App.subscribe.allInstances()
#
#   console.table Instances.find().fetch()
#   instances: Instances.find().fetch()
#
# , require '../InstancesPage.cjsx'
