var actions, assert;

assert = require('assert');

actions = require('./user');

describe('Error actions', function() {
  return it('should create a well formed logout action object', function() {
    var action;
    action = actions.logout();
    return assert.deepEqual(action, {
      type: 'USER_LOGOUT_REQUEST'
    });
  });
});
