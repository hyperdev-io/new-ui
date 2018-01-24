var actions, assert;

assert = require('assert');

actions = require('./errors');

describe('Error actions', function() {
  it('should create a well formed userError action object', function() {
    var action, errObject;
    errObject = {
      err: 'some err'
    };
    action = actions.userError(errObject);
    return assert.deepEqual(action, {
      type: 'USER_ERROR',
      err: errObject
    });
  });
  return it('should create a well formed userErrorAcknowledged action object', function() {
    var action;
    action = actions.userErrorAcknowledged();
    return assert.deepEqual(action, {
      type: 'USER_ERROR_ACK'
    });
  });
});
