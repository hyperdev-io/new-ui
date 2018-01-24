var assert, utils;

assert = require('assert');

utils = require('./utils');

describe('Reducers utils', function() {
  return describe('merge', function() {
    it('should merge two objects, overwriting duplicate properties from the first argument', function() {
      var merged;
      merged = utils.merge({
        a: 1,
        b: 2
      }, {
        c: 3,
        b: 4
      });
      return assert.deepEqual(merged, {
        a: 1,
        b: 4,
        c: 3
      });
    });
    return it('should not change the passed in objects', function() {
      var merged, obj1, obj2;
      obj1 = {
        a: 1,
        b: 2
      };
      obj2 = {
        c: 3,
        b: 4
      };
      merged = utils.merge(obj1, obj2);
      assert.deepEqual(obj1, {
        a: 1,
        b: 2
      });
      return assert.deepEqual(obj2, {
        c: 3,
        b: 4
      });
    });
  });
});
