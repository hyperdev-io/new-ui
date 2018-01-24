module.exports =
  userError: (err) ->
    type: 'USER_ERROR'
    err: err
  userErrorAcknowledged: ->
    type: 'USER_ERROR_ACK'
