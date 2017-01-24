{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  Instances = props.route.Collections.Instances

  console.table Instances.find().fetch()
  instances: Instances.find().fetch()

, require '../InstancesPage.cjsx'
