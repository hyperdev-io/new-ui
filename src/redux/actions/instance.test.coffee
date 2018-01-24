assert  = require 'assert'
{ stopInstanceRequest } = require './instance.coffee'

describe 'Instance actions', ->

  it 'should create a well formed StopInstanceRequest action object', ->
    action = stopInstanceRequest 'myInstance'
    assert.deepEqual action, {type: 'StopInstanceRequest', instanceName: 'myInstance'}
