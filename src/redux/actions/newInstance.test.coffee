assert  = require 'assert'
actions = require './newInstance.coffee'

describe 'New instance actions', ->

  it 'should create a well formed newInstancePageCloseRequest action object', ->
    action = actions.newInstancePageCloseRequest 'appName', 'appVersion'
    assert.deepEqual action, {type: 'NewInstancePageCloseRequest', app: {name: 'appName', version: 'appVersion'}}
