var assert, stopInstanceRequest;

assert = require('assert');

({stopInstanceRequest} = require('./instance'));

describe('Instance actions', function() {
  return it('should create a well formed StopInstanceRequest action object', function() {
    var action;
    action = stopInstanceRequest('myInstance');
    return assert.deepEqual(action, {
      type: 'StopInstanceRequest',
      instanceName: 'myInstance'
    });
  });
});
