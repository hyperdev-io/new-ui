{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Instances = App.collections.Instances

  App.subscribe.allInstances()

  name = props.params.name

  instance: Instances.findOne name: name
  title: name
  emit: App.emit

, require '../InstanceDetailPage.cjsx'
