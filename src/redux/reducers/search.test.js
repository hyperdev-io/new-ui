var assert, defaultState, extend, reducer;

assert = require('assert');

reducer = require('./search');

extend = function(base, extensions) {
  return Object.assign({}, base, extensions);
};

defaultState = {};

describe('Search reducer', function() {
  it('should return initial state on first unhandled action', function() {
    var state;
    state = reducer(null, {
      type: 'UNHANDLED_ACTION'
    });
    return assert.deepEqual(state, defaultState);
  });
  it('should return unchanged state on an unhandled action', function() {
    var state;
    state = reducer({
      some: 'state'
    }, {
      type: 'UNHANDLED_ACTION'
    });
    return assert.deepEqual(state, {
      some: 'state'
    });
  });
  return it('should change app_search state on APP_SEARCH_CHANGED action', function() {
    var state;
    state = reducer(null, {
      type: 'APP_SEARCH_CHANGED',
      value: 'search value'
    });
    return assert.deepEqual(state, extend(defaultState, {
      app_search: 'search value'
    }));
  });
});
