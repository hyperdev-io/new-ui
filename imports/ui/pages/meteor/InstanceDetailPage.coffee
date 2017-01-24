{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  name = props.params.name
  Instances = props.route.Collections.Instances

  instance: Instances.findOne name: name
  title: name

, require '../InstanceDetailPage.cjsx'
