var assert, defaultState, extend, reducer;

assert = require('assert');

reducer = require('./collections');

extend = function(base, extensions) {
  return Object.assign({}, base, extensions);
};

defaultState = {
  user: null,
  apps: [],
  buckets: []
};

describe('Collection reducer', function() {
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
  it('Should change user state on COLLECTIONS/USER action', function() {
    var state;
    state = reducer(null, {
      type: 'COLLECTIONS/USER',
      user: 'some-user'
    });
    return assert.deepEqual(state, extend(defaultState, {
      user: 'some-user'
    }));
  });
  it('Should change apps state on COLLECTIONS/APPS action', function() {
    var state;
    state = reducer(null, {
      type: 'COLLECTIONS/APPS',
      apps: ['app1', 'app2']
    });
    return assert.deepEqual(state, extend(defaultState, {
      apps: ['app1', 'app2']
    }));
  });
  it('Should change instances state on COLLECTIONS/INSTANCES action', function() {
    var state;
    state = reducer(null, {
      type: 'COLLECTIONS/INSTANCES',
      instances: ['instance1', 'instance2']
    });
    return assert.deepEqual(state, extend(defaultState, {
      instances: ['instance1', 'instance2']
    }));
  });
  it('Should change buckets state on COLLECTIONS/BUCKETS action', function() {
    var state;
    state = reducer(null, {
      type: 'COLLECTIONS/BUCKETS',
      buckets: ['b1', 'b2']
    });
    return assert.deepEqual(state, extend(defaultState, {
      buckets: ['b1', 'b2']
    }));
  });
  return it('Should change dataStore state on COLLECTIONS/DATASTORE action', function() {
    var state;
    state = reducer(null, {
      type: 'COLLECTIONS/DATASTORE',
      dataStore: 'mystore'
    });
    return assert.deepEqual(state, extend(defaultState, {
      dataStore: 'mystore'
    }));
  });
});
