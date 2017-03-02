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

  it 'should push a url to the browser history on APP_SELECTED action', ->
    next = sinon.spy()
    browserHistoryMock = sinon.mock browserHistory = {push: ->}
    browserHistoryMock.expects('push').withExactArgs '/apps/appname/version'
    value = nav(browserHistory)(getState:null, dispatch: null)(next) {type: 'APP_SELECTED', value: {name: 'appname', version: 'version'}}
    assert.equal next.notCalled, true, 'Next middleware should not be called'
    browserHistoryMock.verify()
