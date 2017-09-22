{ applyMiddleware } = require 'redux'
{ browserHistory }  = require 'react-router'
navigation          = require './navigation.coffee'
meteor              = require './meteor.coffee'

module.exports = (ddp) ->
   applyMiddleware navigation(browserHistory), meteor(ddp)
