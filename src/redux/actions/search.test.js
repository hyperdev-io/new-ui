var actions, assert;

assert = require('assert');

actions = require('./search');

describe('Search actions', function() {
  return it('should create a well formed appSearchChanged action object', function() {
    var action;
    action = actions.appSearchChanged('searchValue');
    return assert.deepEqual(action, {
      type: 'APP_SEARCH_CHANGED',
      value: 'searchValue'
    });
  });
});
