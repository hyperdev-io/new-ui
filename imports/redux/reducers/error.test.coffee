assert  = require 'assert'
reducer = require './error.coffee'

{merge} = require './utils.coffee'
defaultState = {}

describe 'Error reducer', ->
  it 'should return initial state on first unhandled action', ->
    state = reducer null, {type: 'UNHANDLED_ACTION'}
    assert.deepEqual state, defaultState

  it 'should return unchanged state on an unhandled action', ->
    state = reducer {some: 'state'}, {type: 'UNHANDLED_ACTION'}
    assert.deepEqual state, some: 'state'

  it 'should change message state on USER_ERROR action', ->
    state = reducer null, {type: 'USER_ERROR', err: 'some err'}
    assert.deepEqual state, merge defaultState, message: 'some err'

  it 'Should clear message state on USER_ERROR_ACK action', ->
    state = reducer null, {type: 'USER_ERROR_ACK'}
    assert.deepEqual state, merge defaultState, message: null
