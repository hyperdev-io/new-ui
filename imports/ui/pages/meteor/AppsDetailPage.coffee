_           = require 'lodash'
{ connect } = require 'react-redux'
{saveAppRequest, removeAppRequest, startAppFormRequest} = require '/imports/redux/actions/apps.coffee'

mapStateToProps = (state, { params }) ->
  app = _.find state.collections.apps, {name: params.name, version: params.version}
  app: app
  title: "#{app?.name}:#{app?.version}"
  dockerCompose: app?.dockerCompose
  bigboatCompose: app?.bigboatCompose
  isLoading: not app?

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
