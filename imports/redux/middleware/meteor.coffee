#
# Redux middleware that implements actions as Meteor side-effects
#

{userError} = require '../actions/errors.coffee'

module.exports = (ddp) -> ({ getState, dispatch }) -> (next) -> (action) ->

  saveApp = (app, dockerCompose, bigboatCompose) ->
    ddp.call 'saveApp', app.name, app.version, {raw: dockerCompose}, {raw: bigboatCompose}, (err) ->
      dispatch userError err if err
  
  switch action.type
    when 'SAVE_APP_REQUEST' then saveApp action.app, action.dockerCompose, action.bigboatCompose
    else next action
