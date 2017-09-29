{ merge } = require './utils.coffee'

module.exports = (state = {}, action) ->
  switch action.type
    when 'APP_SEARCH_CHANGED' then merge state, app_search: action.value
    when 'BUCKET_SEARCH_CHANGED' then merge state, bucket_search: action.value
    else state
