assert  = require 'assert'
actions = require './user.coffee'

describe 'Error actions', ->

  it 'should create a well formed logout action object', ->
    action = actions.logout()
    assert.deepEqual action, {type: 'USER_LOGOUT_REQUEST'}
