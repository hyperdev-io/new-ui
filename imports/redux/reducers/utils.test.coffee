assert  = require 'assert'
utils = require './utils.coffee'

describe 'Reducers utils', ->
  describe 'merge', ->
    it 'should merge two objects, overwriting duplicate properties from the first argument', ->
      merged = utils.merge {a: 1, b:2}, {c: 3, b: 4}
      assert.deepEqual merged, {a:1, b:4, c:3}
      
    it 'should not change the passed in objects', ->
      obj1 = {a: 1, b:2}; obj2 = {c: 3, b: 4}
      merged = utils.merge obj1, obj2
      assert.deepEqual obj1, {a: 1, b:2}
      assert.deepEqual obj2, {c: 3, b: 4}
