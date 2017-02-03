{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Apps = App.collections.Apps

  App.subscribe.allApps()

  name = props.params.name
  version = props.params.version

  app: app = Apps.findOne name: name, version: version
  title: "#{name}:#{version}"
  onRemoveApp: -> App.emit 'remove app', app
  onStartApp: -> App.emit 'start app', app

, require '../AppsDetailPage.cjsx'
