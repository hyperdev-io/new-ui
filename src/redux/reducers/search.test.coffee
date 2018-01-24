assert  = require 'assert'
reducer = require './search.coffee'

extend = (base, extensions) -> Object.assign {}, base, extensions
defaultState = {}

describe 'Search reducer', ->
  it 'should return initial state on first unhandled action', ->
    state = reducer null, {type: 'UNHANDLED_ACTION'}
    assert.deepEqual state, defaultState

  it 'should return unchanged state on an unhandled action', ->
    state = reducer {some: 'state'}, {type: 'UNHANDLED_ACTION'}
    assert.deepEqual state, some: 'state'

  it 'should change app_search state on APP_SEARCH_CHANGED action', ->
      state = reducer null, {type: 'APP_SEARCH_CHANGED', value: 'search value'}
      assert.deepEqual state, extend defaultState, app_search: 'search value'
