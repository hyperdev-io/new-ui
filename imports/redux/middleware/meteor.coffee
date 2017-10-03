#
# Redux middleware that implements actions as Meteor side-effects
#

{ userError }             = require '../actions/errors.coffee'
{ goToAppsPage }          = require '../actions/navigation.coffee'
notifications             = require '../actions/notifications.coffee'

module.exports = (ddp) -> ({ getState, dispatch }) ->
  console.log 'init meteor middleware'

  Apps = new Mongo.Collection 'applicationDefs', connection: ddp
  Instances = new Mongo.Collection 'instances', connection: ddp
  StorageBuckets = new Mongo.Collection 'storageBuckets', connection: ddp
  DataStores = new Mongo.Collection 'datastores',  connection: ddp
  Services = new Mongo.Collection 'services',  connection: ddp
  AppStore = new Mongo.Collection 'appstore',  connection: ddp
  #     Users: Meteor.users
  ddp.subscribe 'applicationDefs'
  ddp.subscribe 'instances'
  ddp.subscribe 'storage'
  ddp.subscribe 'datastores'
  ddp.subscribe 'allUsers'
  ddp.subscribe 'allUserInfo'
  ddp.subscribe 'services'
  ddp.subscribe 'appstore'

  Tracker.autorun ->
    dispatch type: 'COLLECTIONS/USERS', users: Meteor.users.find().fetch()

  Tracker.autorun ->
    dispatch type: 'COLLECTIONS/USER', user: Meteor.user()

  Tracker.autorun ->
    apps = Apps.find({}, sort: name: 1, version: 1).fetch()
    dispatch type: 'COLLECTIONS/APPS', apps: apps

  instanceDispatch = _.debounce dispatch, 500
  instances = Instances.find({}, sort: name: 1)
  instances.observe
    added: (instance) ->
      dispatch notifications.instanceStartedNotification instance if instance.state is 'created'
    removed: (instance) ->
      dispatch notifications.instanceStoppedNotification instance
    changed: (doc, oldDoc) ->
      return if doc.state is oldDoc.state
      dispatch notifications.instanceStartedNotification doc if doc.state is 'created'
      dispatch notifications.instanceRunningNotification doc if doc.state is 'running'
      dispatch notifications.instanceStoppingNotification doc if doc.state is 'stopping'
  Tracker.autorun ->
    instanceDispatch type: 'COLLECTIONS/INSTANCES', instances: instances.fetch()

  Tracker.autorun ->
    buckets = StorageBuckets.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/BUCKETS', buckets: buckets

  Tracker.autorun ->
    dataStore = DataStores.findOne()
    dispatch type: 'COLLECTIONS/DATASTORE', dataStore: dataStore

  Tracker.autorun ->
    services = Services.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/SERVICES', services: services

  Tracker.autorun ->
    apps = AppStore.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/APPSTORE', apps: apps

  (next) -> (action) ->

    dispatchErrIfAny = (err) -> dispatch userError err if err
    removeAppErrorHandler = (app) -> (err) ->
      dispatch goToAppsPage() unless err
      dispatch notifications.appRemovedNotification app unless err
      dispatchErrIfAny err

    saveApp = (app, dockerCompose, bigboatCompose) ->
      ddp.call 'saveApp', app.name, app.version, {raw: dockerCompose}, {raw: bigboatCompose}, (err) ->
        dispatchErrIfAny err
        dispatch notifications.appSavedNotification app unless err
    removeApp = (app) ->
      ddp.call 'deleteApp', app.name, app.version, removeAppErrorHandler app

    startApp = (app, version, instanceName) ->
      #startApp: (app, version, instance, parameters = {}, options = {}) ->
      ddp.call 'startApp', app, version, instanceName, (err) -> dispatchErrIfAny err

    stopInstance = (instanceName) ->
      dispatch notifications.instanceStopRequestedNotification instanceName
      ddp.call 'stopInstance', instanceName, dispatchErrIfAny

    copyBucket = (from, to) ->
      dispatch notifications.copyBucketRequestedNotification from, to
      ddp.call 'storage/buckets/copy', from, to, dispatchErrIfAny

    login = (username, password) ->
      Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}, dispatchErrIfAny
    logout = -> Meteor.logout()

    switch action.type
      when 'SAVE_APP_REQUEST' then saveApp action.app, action.dockerCompose, action.bigboatCompose
      when 'REMOVE_APP_REQUEST' then removeApp action.app
      when 'START_APP_REQUEST' then startApp action.app.name, action.app.version, action.instanceName
      when 'USER_LOGOUT_REQUEST' then logout()
      when 'CopyBucketRequest' then copyBucket action.fromBucket, action.toBucket
      when 'LoginRequest' then login action.username, action.password
      when 'StopInstanceRequest' then stopInstance action.instanceName
      else next action
