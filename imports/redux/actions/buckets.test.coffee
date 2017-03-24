assert  = require 'assert'
actions = require './buckets.coffee'

describe 'Buckets actions', ->

  it 'should create a well formed openBucketPageRequest action object', ->
    action = actions.openBucketPageRequest 'bucket1'
    assert.deepEqual action, {type: 'OpenBucketPageRequest', name: 'bucket1'}
