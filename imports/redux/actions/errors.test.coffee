assert  = require 'assert'
actions = require './errors.coffee'

describe 'Error actions', ->
  
  it 'should create a well formed userError action object', ->
    errObject = {err: 'some err'}
    action = actions.userError errObject
    assert.deepEqual action, {type: 'USER_ERROR', err: errObject}

  it 'should create a well formed userErrorAcknowledged action object', ->
    action = actions.userErrorAcknowledged()
    assert.deepEqual action, type: 'USER_ERROR_ACK'
