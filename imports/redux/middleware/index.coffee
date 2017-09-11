{ applyMiddleware } = require 'redux'
{ browserHistory }  = require 'react-router'
navigation          = require './navigation.coffee'
meteor              = require './meteor.coffee'
notifications       = require './notifications.coffee'

module.exports = (ddp) ->
   applyMiddleware notifications, navigation(browserHistory), meteor(ddp)
