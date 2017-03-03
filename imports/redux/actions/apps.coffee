module.exports =
  saveAppRequest: (app, dockerCompose, bigboatCompose) ->
    type: 'SAVE_APP_REQUEST'
    app: app
    dockerCompose: dockerCompose
    bigboatCompose: bigboatCompose
  removeAppRequest: (app) ->
    type: 'REMOVE_APP_REQUEST'
    app: app
  startAppRequest: (app) ->
    type: 'START_APP_REQUEST'
    app: app
