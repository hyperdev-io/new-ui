React               = require 'react'
{ Meteor }          = require 'meteor/meteor'
{ Session }         = require 'meteor/session'
{ createContainer } = require 'meteor/react-meteor-data'
{ render }          = require 'react-dom'
{ browserHistory }  = require 'react-router'
{ EventEmitter }    = require 'fbemitter'
routes              = require '../imports/startup/routes.cjsx'
ErrorMapper         = require '../imports/ErrorMapper.coffee'

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
  onEvent 'remove app', (app) -> ddp.call 'deleteApp', app.name, app.version, (err) ->
    eventEmitter.emit 'show error message', err if err
    eventEmitter.emit 'app removed', app unless err
  onEvent 'app removed', (app) ->
    eventEmitter.emit 'show info message', "App #{app.name}:#{app.version} is deleted."
    browserHistory.push '/apps'
  onEvent 'start app', (app) -> console.log 'start app', app

  onEvent 'show error message', (message) -> Session.set 'globalErrorMessage', ErrorMapper message
  onEvent 'clear error message', -> Session.set 'globalErrorMessage', null
  onEvent 'show info message', (message) -> Session.set 'globalInfoMessage', message
  onEvent 'clear info message', -> Session.set 'globalInfoMessage', null

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
    globalErrorMessage: -> Session.get 'globalErrorMessage'
    globalInfoMessage: -> Session.get 'globalInfoMessage'

, Wrapper

Meteor.startup ->
  render <WrappedWrapper />, document.getElementById 'render-target'
