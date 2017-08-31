_           = require 'lodash'
{ connect } = require 'react-redux'
{saveAppRequest, removeAppRequest, startAppFormRequest} = require '/imports/redux/actions/apps.coffee'

appTemplate =
  name: 'MyNewApp'
  version: '1.0'
  dockerCompose: """
  version: '2.0'
  services:
    www:
      image: nginx
  """
  bigboatCompose:"""
  name: MyNewApp
  version: '1.0'
  """

mapStateToProps = (state, { params }) ->
  if params.name and params.version
    app = _.find state.collections.apps, {name: params.name, version: params.version}
    title = "#{app?.name}:#{app?.version}"
    isNewApp = false
  else
    app = appTemplate
    title = 'New App'
    isNewApp = true
  app: app
  title: title
  dockerCompose: app?.dockerCompose
  bigboatCompose: app?.bigboatCompose
  isLoading: not app?
  isNewApp: isNewApp

mapDispatchToProps = (dispatch) ->
  onSaveApp: (app, dockerCompose, bigboatCompose)->
    dispatch saveAppRequest app, dockerCompose, bigboatCompose
  onRemoveApp: (app) -> dispatch removeAppRequest app
  onStartApp: (app) -> dispatch startAppFormRequest app


mergeProps = (stateProps, dispatchProps, ownProps) ->
  app = stateProps.app
  Object.assign {}, stateProps, dispatchProps, ownProps,
    onSaveApp: (dockerCompose, bigboatCompose)->
      dispatchProps.onSaveApp app, (dockerCompose or app.dockerCompose), (bigboatCompose or app.bigboatCompose)
    onRemoveApp: -> dispatchProps.onRemoveApp app
    onStartApp: -> dispatchProps.onStartApp app

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../AppsDetailPage.cjsx'
