assert  = require 'assert'
sinon   = require 'sinon'
meteor  = require './meteor.coffee'

extend = (base, extensions) -> Object.assign {}, base, extensions
defaultState = {user: null, apps: [], buckets: []}

# describe 'Meteor middleware', ->
#   it 'should call next middleware with unchanged action on an unhandled action', ->
#     next = sinon.spy(-> 'some return value')
#     value = meteor(null)(getState:null, dispatch: null)(next) {type: 'UNHANDLED_ACTION'}
#     assert.equal value, 'some return value'
#     assert.equal next.calledOnce, true, 'Next middleware not called'
#
#   it 'should call a ddp save method on SAVE_APP_REQUEST action', ->
#     app = name: 'myapp', version: 'myversion'
#     bigboatCompose = 'some bb compose'
#     dockerCompose = 'some docker compose'
#
#     next = sinon.spy()
#     ddpMock = sinon.mock ddp = call: ->
#     ddpMock.expects('call').withArgs('saveApp', app.name, app.version, {raw: dockerCompose}, {raw: bigboatCompose}).once()
#
#     value = meteor(ddp)(getState:null, dispatch: null)(next) {type: 'SAVE_APP_REQUEST', app:app, dockerCompose:dockerCompose, bigboatCompose:bigboatCompose}
#     assert.equal next.notCalled, true, 'Next middleware should not be called'
#     ddpMock.verify()
