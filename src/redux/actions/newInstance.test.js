var actions, assert;

assert = require('assert');

actions = require('./newInstance');

describe('New instance actions', function() {
  return it('should create a well formed newInstancePageCloseRequest action object', function() {
    var action;
    action = actions.newInstancePageCloseRequest('appName', 'appVersion');
    return assert.deepEqual(action, {
      type: 'NewInstancePageCloseRequest',
      app: {
        name: 'appName',
        version: 'appVersion'
      }
    });
  });
});
