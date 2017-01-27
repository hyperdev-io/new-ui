React               = require 'react'
{ Meteor }          = require 'meteor/meteor'
{ Session }         = require 'meteor/session'
{ createContainer } = require 'meteor/react-meteor-data'
{ render }          = require 'react-dom'
{ EventEmitter }    = require 'fbemitter'
routes              = require '../imports/startup/routes.cjsx'

Wrapper = React.createClass
  displayName: 'MeteorDataWrapper'

  render: -> routes @props

WrappedWrapper = createContainer (props) ->

  ddp = DDP.connect 'http://www.dashboard.vib.ictu'
  Meteor.remoteConnection = ddp
  Accounts.connection = ddp
  eventEmitter = new EventEmitter

  storeEventDataInSession = (eventName, sessVar) ->
    eventEmitter.addListener eventName, (data) ->
      console.log eventName, sessVar, data
      Session.set sessVar, data

  storeEventDataInSession 'app name selected', 'selectedAppName'
  storeEventDataInSession 'app search entered', 'appSearchValue'

  eventEmitter.addListener 'stop instance', (instanceName) ->
    ddp.call 'stopInstance', instanceName
    console.log 'stop instance received for ', instanceName

  emit: (evt, data) -> eventEmitter.emit evt, data
  collections:
    Instances: new Mongo.Collection 'instances', connection: ddp
    Apps: new Mongo.Collection 'applicationDefs', connection: ddp
    StorageBuckets: new Mongo.Collection 'storageBuckets', connection: ddp
  subscribe:
    allInstances: -> ddp.subscribe 'instances'
    allApps: -> ddp.subscribe 'applicationDefs'
    allStorageBuckets: -> ddp.subscribe 'storage'
  state:
    selectedAppName: -> Session.get 'selectedAppName'
    appSearchValue: -> Session.get 'appSearchValue'

, Wrapper

Meteor.startup ->
  render <WrappedWrapper />, document.getElementById 'render-target'
