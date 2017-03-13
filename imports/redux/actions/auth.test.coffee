assert  = require 'assert'
{loginRequest} = require './auth.coffee'

describe 'Auth actions', ->

  it 'should create a well formed LoginRequest action object', ->
    action = loginRequest 'username1234', 'password123'
    assert.deepEqual action, {type: 'LoginRequest', username: 'username1234', password: 'password123'}
