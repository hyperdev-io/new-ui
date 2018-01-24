var assert, loginRequest;

assert = require('assert');

({loginRequest} = require('./auth'));

describe('Auth actions', function() {
  return it('should create a well formed LoginRequest action object', function() {
    var action;
    action = loginRequest('username1234', 'password123');
    return assert.deepEqual(action, {
      type: 'LoginRequest',
      username: 'username1234',
      password: 'password123'
    });
  });
});
