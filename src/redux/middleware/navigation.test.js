var assert, defaultState, extend, nav, sinon;

assert = require('assert');

sinon = require('sinon');

nav = require('./navigation');

extend = function(base, extensions) {
  return Object.assign({}, base, extensions);
};

defaultState = {
  user: null,
  apps: [],
  buckets: []
};

describe('Navigation middleware', function() {
  var browserHistoryTest;
  it('should call next middleware with unchanged action on an unhandled action', function() {
    var next, value;
    next = sinon.spy(function() {
      return 'some return value';
    });
    value = nav(null)({
      getState: null,
      dispatch: null
    })(next)({
      type: 'UNHANDLED_ACTION'
    });
    assert.equal(value, 'some return value');
    return assert.equal(next.calledOnce, true, 'Next middleware not called');
  });
  browserHistoryTest = function(sourceAction, targetBrowserUrl, expectedMethod = 'push', browserHistoryGetCurrentLocation = function() {}) {
    var browserHistory, browserHistoryMock, next, value;
    next = sinon.spy();
    browserHistoryMock = sinon.mock(browserHistory = {
      push: (function() {}),
      getCurrentLocation: browserHistoryGetCurrentLocation,
      replace: (function() {})
    });
    browserHistoryMock.expects(expectedMethod).withExactArgs(targetBrowserUrl);
    value = nav(browserHistory)({
      getState: null,
      dispatch: null
    })(next)(sourceAction);
    assert.equal(next.notCalled, true, 'Next middleware should not be called');
    return browserHistoryMock.verify();
  };
  it('should push a url to the browser history on APP_SELECTED action', function() {
    return browserHistoryTest({
      type: 'APP_SELECTED',
      value: {
        name: 'appname',
        version: 'version'
      }
    }, '/apps/appname/version');
  });
  it('should push the appropriate url to the browser history on START_APP_FORM_REQUEST action', function() {
    return browserHistoryTest({
      type: 'START_APP_FORM_REQUEST',
      app: {
        name: 'myapp',
        version: 'myversion'
      }
    }, '/instance/new/myapp/myversion?');
  });
  it('should push the appropriate url to the browser history on START_APP_FORM_REQUEST action that contains query parameters', function() {
    var action;
    action = {
      type: 'START_APP_FORM_REQUEST',
      app: {
        name: 'myapp',
        version: 'myversion'
      },
      params: {
        name: 'my-instance',
        bucket: 'my-storage-bucket',
        params_param1: 'value1'
      }
    };
    return browserHistoryTest(action, '/instance/new/myapp/myversion?name=my-instance&bucket=my-storage-bucket&params_param1=value1');
  });
  it('should PUSH the url to the browser history on START_APP_FORM_REQUEST when the current url doesnt match `^/instance/new`', function() {
    var action;
    action = {
      type: 'START_APP_FORM_REQUEST',
      app: {
        name: 'myapp',
        version: 'myversion'
      }
    };
    return browserHistoryTest(action, '/instance/new/myapp/myversion?', 'push');
  });
  return it('should REPLACE the url in the browser history on START_APP_FORM_REQUEST when the current url matches `^/instance/new`', function() {
    var action;
    action = {
      type: 'START_APP_FORM_REQUEST',
      app: {
        name: 'myapp',
        version: 'myversion'
      }
    };
    return browserHistoryTest(action, '/instance/new/myapp/myversion?', 'push', (function() {
      return {
        pathname: '/insance/new/myapp/myversion?name=newInstance'
      };
    }));
  });
});
