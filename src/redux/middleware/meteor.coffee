#
# Redux middleware that implements actions as Meteor side-effects
#

_                         = require 'lodash'
{ userError }             = require '../actions/errors.coffee'
{ goToAppsPage }          = require '../actions/navigation.coffee'
notifications             = require '../actions/notifications.coffee'

module.exports = (ddp) -> ({ getState, dispatch }) ->
  console.log 'init meteor middleware'

  (next) -> (action) ->

    dispatchErrIfAny = (err) -> dispatch userError err if err

    getServiceLogs = (params) ->
      ddp.call 'getLog', params, (err, result) ->
        console.log err, result
        dispatchErrIfAny err
        dispatch type: 'COLLECTIONS/LOG', log: result

    copyBucket = (from, to) ->
      dispatch notifications.copyBucketRequestedNotification from, to
      ddp.call 'storage/buckets/copy', from, to, dispatchErrIfAny
    deleteBucket = (name) ->
      bucket = _.find getState().collections.buckets, name: name
      dispatch notifications.deleteBucketRequestedNotification name
      ddp.call 'storage/buckets/delete', bucket._id, dispatchErrIfAny

    login = (username, password) ->
      Meteor.loginWithLDAP username, password, searchBeforeBind: {'uid': username}, dispatchErrIfAny
    logout = -> Meteor.logout()

    switch action.type
      when 'USER_LOGOUT_REQUEST' then logout()
      when 'CopyBucketRequest' then copyBucket action.fromBucket, action.toBucket
      when 'DeleteBucketRequest' then deleteBucket action.bucket
      when 'LoginRequest' then login action.username, action.password
      when 'GetServiceLogsRequest' then getServiceLogs action
      else next action
