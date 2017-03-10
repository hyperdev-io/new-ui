#
# Redux middleware that implements actions as Meteor side-effects
#

{userError} = require '../actions/errors.coffee'

module.exports = (ddp) -> ({ getState, dispatch }) ->

  console.log 'init meteor middleware'

  Apps = new Mongo.Collection 'applicationDefs', connection: ddp
  Instances = new Mongo.Collection 'instances', connection: ddp
  StorageBuckets = new Mongo.Collection 'storageBuckets', connection: ddp
  DataStores = new Mongo.Collection 'datastores',  connection: ddp
  #     Users: Meteor.users
  ddp.subscribe 'applicationDefs'
  ddp.subscribe 'instances'
  ddp.subscribe 'storage'
  ddp.subscribe 'datastores'

  Tracker.autorun ->
    dispatch type: 'COLLECTIONS/USER', user: Meteor.user()

  Tracker.autorun ->
    apps = Apps.find({}, sort: name: 1, version: 1).fetch()
    dispatch type: 'COLLECTIONS/APPS', apps: apps

  Tracker.autorun ->
    instances = Instances.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/INSTANCES', instances: instances

  Tracker.autorun ->
    buckets = StorageBuckets.find({}, sort: name: 1).fetch()
    dispatch type: 'COLLECTIONS/BUCKETS', buckets: buckets

  Tracker.autorun ->
    dataStore = DataStores.findOne()
    dispatch type: 'COLLECTIONS/DATASTORE', dataStore: dataStore

  (next) -> (action) ->

    saveApp = (app, dockerCompose, bigboatCompose) ->
      ddp.call 'saveApp', app.name, app.version, {raw: dockerCompose}, {raw: bigboatCompose}, (err) ->
        dispatch userError err if err

    switch action.type
      when 'SAVE_APP_REQUEST' then saveApp action.app, action.dockerCompose, action.bigboatCompose
      else next action
