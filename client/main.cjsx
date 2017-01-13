React = require 'react'
{ Meteor } = require 'meteor/meteor'
{ render } = require 'react-dom'

routes = require '../imports/startup/routes.cjsx'

Meteor.startup ->
  render routes(), document.getElementById('render-target')
