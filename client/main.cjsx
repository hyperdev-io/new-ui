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

  ddp = DDP.connect 'http://localhost:3000'
  Meteor.remoteConnection = ddp
  Accounts.connection = ddp
  eventEmitter = new EventEmitter
  eventEmitter.addListener 'stop instance', (instanceName) ->
    ddp.call 'stopInstance', instanceName
    console.log 'stop instance received for ', instanceName

  eventEmitter.addListener 'app name selected', (appName) ->
    console.log 'app name selected', appName
    Session.set 'selectedAppName', appName

  emit: (evt, data) -> eventEmitter.emit evt, data
  collections:
    Instances: new Mongo.Collection 'instances', connection: ddp
    Apps: new Mongo.Collection 'applicationDefs', connection: ddp
  subscribe:
    allInstances: -> ddp.subscribe 'instances'
    allApps: -> ddp.subscribe 'applicationDefs'
  state:
    selectedAppName: -> Session.get 'selectedAppName'

, Wrapper

Meteor.startup ->
  render <WrappedWrapper />, document.getElementById 'render-target'
