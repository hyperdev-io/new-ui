{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  Apps = App.collections.Apps

  App.subscribe.allApps()

  name = props.params.name
  version = props.params.version

  app = Apps.findOne name: name, version: version

  title: "#{name}:#{version}"
  dockerCompose: app?.dockerCompose
  bigboatCompose: app?.bigboatCompose
  onSaveApp: (dockerCompose, bigboatCompose)-> App.emit 'save app', app, dockerCompose, bigboatCompose
  onRemoveApp: -> App.emit 'remove app', app
  onStartApp: -> App.emit 'start app', app

, require '../AppsDetailPage.cjsx'
