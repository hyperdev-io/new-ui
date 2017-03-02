_           = require 'lodash'
{ connect }        = require 'react-redux'

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  title: instance?.name
  instance: instance
  isLoading: not instance?

module.exports = connect(mapStateToProps) require '../InstanceDetailPage.cjsx'


# { createContainer } = require 'meteor/react-meteor-data'
#
#
# module.exports = createContainer (props) ->
#   App = props.route.App
#   Instances = App.collections.Instances
#
#   App.subscribe.allInstances()
#
#   name = props.params.name
#
#   instance: Instances.findOne name: name
#   title: name
#   emit: App.emit
#
# , require '../InstanceDetailPage.cjsx'
