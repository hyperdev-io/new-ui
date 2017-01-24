React       = require 'react'
{ Meteor }  = require 'meteor/meteor'
{ render }  = require 'react-dom'
routes      = require '../imports/startup/routes.cjsx'

ddp = DDP.connect 'http://localhost:3000'
ddp.subscribe 'instances'

Collections =
  Instances: new Mongo.Collection 'instances', connection: ddp

Meteor.startup ->
  render routes(Collections), document.getElementById('render-target')
