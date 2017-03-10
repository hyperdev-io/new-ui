assert  = require 'assert'
actions = require './search.coffee'

describe 'Search actions', ->

  it 'should create a well formed appSearchChanged action object', ->
    action = actions.appSearchChanged 'searchValue'
    assert.deepEqual action, {type: 'APP_SEARCH_CHANGED', value: 'searchValue'}
