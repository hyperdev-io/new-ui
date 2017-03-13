assert  = require 'assert'
sinon   = require 'sinon'
nav     = require './navigation.coffee'

extend = (base, extensions) -> Object.assign {}, base, extensions
defaultState = {user: null, apps: [], buckets: []}

describe 'Navigation middleware', ->
  it 'should call next middleware with unchanged action on an unhandled action', ->
    next = sinon.spy(-> 'some return value')
    value = nav(null)(getState:null, dispatch: null)(next) {type: 'UNHANDLED_ACTION'}
    assert.equal value, 'some return value'
    assert.equal next.calledOnce, true, 'Next middleware not called'

  browserHistoryTest = (sourceAction, targetBrowserUrl, expectedMethod='push', browserHistoryGetCurrentLocation=->) ->
    next = sinon.spy()
    browserHistoryMock = sinon.mock browserHistory = {push: (->), getCurrentLocation: browserHistoryGetCurrentLocation, replace: (->)}
    browserHistoryMock.expects(expectedMethod).withExactArgs targetBrowserUrl
    value = nav(browserHistory)(getState:null, dispatch: null)(next) sourceAction
    assert.equal next.notCalled, true, 'Next middleware should not be called'
    browserHistoryMock.verify()

  it 'should push a url to the browser history on APP_SELECTED action', ->
    browserHistoryTest {type: 'APP_SELECTED', value: {name: 'appname', version: 'version'}}, '/apps/appname/version'

  it 'should push the appropriate url to the browser history on START_APP_REQUEST action', ->
    browserHistoryTest {type: 'START_APP_REQUEST', app: {name: 'myapp', version: 'myversion'}}, '/instance/new/myapp/myversion?'


  it 'should push the appropriate url to the browser history on START_APP_REQUEST action that contains query parameters', ->
    action =
      type: 'START_APP_REQUEST'
      app: {name: 'myapp', version: 'myversion'}
      params: {name: 'my-instance', bucket: 'my-storage-bucket', params_param1: 'value1'}
    browserHistoryTest action, '/instance/new/myapp/myversion?name=my-instance&bucket=my-storage-bucket&params_param1=value1'

  it 'should PUSH the url to the browser history on START_APP_REQUEST when the current url doesnt match `^/instance/new`', ->
    action = type: 'START_APP_REQUEST', app: {name: 'myapp', version: 'myversion'}
    browserHistoryTest action, '/instance/new/myapp/myversion?', 'push'

  it 'should REPLACE the url in the browser history on START_APP_REQUEST when the current url matches `^/instance/new`', ->
    action = type: 'START_APP_REQUEST', app: {name: 'myapp', version: 'myversion'}
    browserHistoryTest action, '/instance/new/myapp/myversion?', 'push', (-> pathname: '/insance/new/myapp/myversion?name=newInstance')
