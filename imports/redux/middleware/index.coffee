{ applyMiddleware } = require 'redux'
{ browserHistory }  = require 'react-router'
nav = require './navigation.coffee'

module.exports = applyMiddleware nav(browserHistory)
