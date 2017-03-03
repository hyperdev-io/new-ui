{ merge } = require './utils.coffee'

module.exports = (state = {}, action) ->
  switch action.type
    when 'USER_ERROR' then merge state, message: "#{action.err}"
    when 'USER_ERROR_ACK' then merge state, message: null
    else state
