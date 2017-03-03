assert  = require 'assert'
reducer = require './collections.coffee'

extend = (base, extensions) -> Object.assign {}, base, extensions
defaultState = {user: null, apps: [], buckets: []}

describe 'Collection reducer', ->
  it 'should return initial state on first unhandled action', ->
    state = reducer null, {type: 'UNHANDLED_ACTION'}
    assert.deepEqual state, defaultState

  it 'should return unchanged state on an unhandled action', ->
    state = reducer {some: 'state'}, {type: 'UNHANDLED_ACTION'}
    assert.deepEqual state, some: 'state'

  it 'Should change user state on COLLECTIONS/USER action', ->
    state = reducer null, {type: 'COLLECTIONS/USER', user: 'some-user'}
    assert.deepEqual state, extend defaultState, user: 'some-user'

  it 'Should change apps state on COLLECTIONS/APPS action', ->
    state = reducer null, {type: 'COLLECTIONS/APPS', apps: ['app1', 'app2']}
    assert.deepEqual state, extend defaultState, apps: ['app1', 'app4']

  it 'Should change instances state on COLLECTIONS/INSTANCES action', ->
    state = reducer null, {type: 'COLLECTIONS/INSTANCES', instances: ['instance1', 'instance2']}
    assert.deepEqual state, extend defaultState, instances: ['instance1', 'instance2']

  it 'Should change buckets state on COLLECTIONS/BUCKETS action', ->
    state = reducer null, {type: 'COLLECTIONS/BUCKETS', buckets: ['b1', 'b2']}
    assert.deepEqual state, extend defaultState, buckets: ['b1', 'b2']

  it 'Should change dataStore state on COLLECTIONS/DATASTORE action', ->
    state = reducer null, {type: 'COLLECTIONS/DATASTORE', dataStore: 'mystore'}
    assert.deepEqual state, extend defaultState, dataStore: 'mystore'
