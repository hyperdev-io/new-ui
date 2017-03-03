{ applyMiddleware } = require 'redux'
{ browserHistory }  = require 'react-router'
nav = require './navigation.coffee'
meteor = require './meteor.coffee'

module.exports = (ddp) ->
   applyMiddleware nav(browserHistory), meteor(ddp)
