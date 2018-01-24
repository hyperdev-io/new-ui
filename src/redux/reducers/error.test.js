var assert, defaultState, merge, reducer;

assert = require('assert');

reducer = require('./error');

({merge} = require('./utils'));

defaultState = {};

describe('Error reducer', function() {
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
  it('should change message state on USER_ERROR action', function() {
    var state;
    state = reducer(null, {
      type: 'USER_ERROR',
      err: 'some err'
    });
    return assert.deepEqual(state, merge(defaultState, {
      message: 'some err'
    }));
  });
  return it('Should clear message state on USER_ERROR_ACK action', function() {
    var state;
    state = reducer(null, {
      type: 'USER_ERROR_ACK'
    });
    return assert.deepEqual(state, merge(defaultState, {
      message: null
    }));
  });
});
