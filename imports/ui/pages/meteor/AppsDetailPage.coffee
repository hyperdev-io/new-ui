_           = require 'lodash'
{ connect } = require 'react-redux'

mapStateToProps = (state, { params }) ->
  console.log 'state!@!@', state
  app = _.find state.apps, {name: params.name, version: params.version}
  console.log 'app', app
  title: "#{app.name}:#{app.version}"
  dockerCompose: app.dockerCompose
  bigboatCompose: app.bigboatCompose

mapDispatchToProps = (dispatch) ->
  onSaveApp: (dockerCompose, bigboatCompose)->
    App.emit 'save app', app, (dockerCompose or app.dockerCompose), (bigboatCompose or app.bigboatCompose)
  onRemoveApp: -> App.emit 'remove app', app
  onStartApp: -> App.emit 'start app', app

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../AppsDetailPage.cjsx'

# { createContainer } = require 'meteor/react-meteor-data'
#
#
# module.exports = createContainer (props) ->
#   App = props.route.App
#   Apps = App.collections.Apps
#
#   App.subscribe.allApps()
#
#   name = props.params.name
#   version = props.params.version
#
#   app = Apps.findOne name: name, version: version
#
#   title: "#{name}:#{version}"
#   dockerCompose: app?.dockerCompose
#   bigboatCompose: app?.bigboatCompose
#   onSaveApp: (dockerCompose, bigboatCompose)->
#     App.emit 'save app', app, (dockerCompose or app.dockerCompose), (bigboatCompose or app.bigboatCompose)
#   onRemoveApp: -> App.emit 'remove app', app
#   onStartApp: -> App.emit 'start app', app
#
# , require '../AppsDetailPage.cjsx'
