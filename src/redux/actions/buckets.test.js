var actions, assert;

assert = require('assert');

actions = require('./buckets');

describe('Buckets actions', function() {
  return it('should create a well formed openBucketPageRequest action object', function() {
    var action;
    action = actions.openBucketPageRequest('bucket1');
    return assert.deepEqual(action, {
      type: 'OpenBucketPageRequest',
      name: 'bucket1'
    });
  });
});
