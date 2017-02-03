React               = require 'react'
{ Meteor }          = require 'meteor/meteor'
{ Session }         = require 'meteor/session'
{ createContainer } = require 'meteor/react-meteor-data'
{ render }          = require 'react-dom'
{ browserHistory }  = require 'react-router'
{ EventEmitter }    = require 'fbemitter'
routes              = require '../imports/startup/routes.cjsx'

Wrapper = React.createClass
  displayName: 'MeteorDataWrapper'

  render: -> routes @props

WrappedWrapper = createContainer (props) ->

  ddp = DDP.connect Meteor.settings.public.ddpServer
  Meteor.remoteConnection = ddp
  Accounts.connection = ddp
  eventEmitter = new EventEmitter

  storeDataInSession = (sessVar) -> (data) ->
    console.log 'Session.set', sessVar, data
    Session.set sessVar, data

  onEvent = (eventName, callbacks...) ->
    eventEmitter.addListener eventName, (data) ->
      console.log "Event '#{eventName}' happened", data
      cb data for cb in callbacks

  onEvent 'app name selected', storeDataInSession('selectedAppName'), (app) -> browserHistory.push("/apps/#{app.name}/#{app.version}")
  onEvent 'app search entered', storeDataInSession('appSearchValue')
  onEvent 'stop instance', (instanceName) -> ddp.call 'stopInstance', instanceName
  onEvent 'remove app', (app) -> console.log 'remove app', app
  onEvent 'start app', (app) -> console.log 'start app', app

  emit: (evt, data) -> eventEmitter.emit evt, data
  collections:
    Instances: new Mongo.Collection 'instances', connection: ddp
    Apps: new Mongo.Collection 'applicationDefs', connection: ddp
    StorageBuckets: new Mongo.Collection 'storageBuckets', connection: ddp
    DataStores: new Mongo.Collection 'datastores',  connection: ddp
  subscribe:
    allInstances: -> ddp.subscribe 'instances'
    allApps: -> ddp.subscribe 'applicationDefs'
    allStorageBuckets: -> ddp.subscribe 'storage'
    allDataStores: -> ddp.subscribe 'datastores'
  state:
    selectedAppName: -> Session.get 'selectedAppName'
    appSearchValue: -> Session.get 'appSearchValue'

, Wrapper

Meteor.startup ->
  render <WrappedWrapper />, document.getElementById 'render-target'
