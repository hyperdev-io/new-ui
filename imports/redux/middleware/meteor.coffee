#
# Redux middleware that implements actions as Meteor side-effects
#

{ userError } = require '../actions/errors.coffee'

module.exports = (ddp) -> ({ getState, dispatch }) ->

  console.log 'init meteor middleware'

  Apps = new Mongo.Collection 'applicationDefs', connection: ddp
  Instances = new Mongo.Collection 'instances', connection: ddp
  StorageBuckets = new Mongo.Collection 'storageBuckets', connection: ddp
  DataStores = new Mongo.Collection 'datastores',  connection: ddp
  Services = new Mongo.Collection 'services',  connection: ddp
  #     Users: Meteor.users
  ddp.subscribe 'applicationDefs'
  ddp.subscribe 'instances'
  ddp.subscribe 'storage'
  ddp.subscribe 'datastores'
  ddp.subscribe 'allUsers'
  ddp.subscribe 'allUserInfo'
  ddp.subscribe 'services'

  Tracker.autorun ->
    dispatch type: 'COLLECTIONS/USERS', users: Meteor.users.find().fetch()

  Tracker.autorun ->
    dispatch type: 'COLLECTIONS/USER', user: Meteor.user()

  Tracker.autorun ->
    apps = Apps.find({}, sort: name: 1, version: 1).fetch()
    dispatch type: 'COLLECTIONS/APPS', apps: apps

  instanceDispatch = _.debounce dispatch, 500
  Tracker.autorun ->
    instances = Instances.find({}, sort: name: 1).fetch()
    instanceDispatch type: 'COLLECTIONS/INSTANCES', instances: instances

  Tracker.autorun ->
    buckets = StorageBuckets.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/BUCKETS', buckets: buckets

  Tracker.autorun ->
    dataStore = DataStores.findOne()
    dispatch type: 'COLLECTIONS/DATASTORE', dataStore: dataStore

  Tracker.autorun ->
    services = Services.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/SERVICES', services: services

  (next) -> (action) ->

    dispatchErrIfAny = (err) -> dispatch userError err if err

    saveApp = (app, dockerCompose, bigboatCompose) ->
      ddp.call 'saveApp', app.name, app.version, {raw: dockerCompose}, {raw: bigboatCompose}, dispatchErrIfAny

    startApp = (app, version, instanceName) ->
      #startApp: (app, version, instance, parameters = {}, options = {}) ->
      ddp.call 'startApp', app, version, instanceName, dispatchErrIfAny

    stopInstance = (instanceName) ->
      ddp.call 'stopInstance', instanceName, dispatchErrIfAny

    login = (username, password) ->
      Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}, dispatchErrIfAny

    switch action.type
      when 'SAVE_APP_REQUEST' then saveApp action.app, action.dockerCompose, action.bigboatCompose
      when 'START_APP_REQUEST' then startApp action.app.name, action.app.version, action.instanceName
      when 'LoginRequest' then login action.username, action.password
      when 'StopInstanceRequest' then stopInstance action.instanceName
      else next action
