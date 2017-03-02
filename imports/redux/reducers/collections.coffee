{ merge } = require './utils.coffee'

module.exports = (state = {user: null, apps: [], buckets: []}, action) ->
  switch action.type
    when 'COLLECTIONS/USER' then merge state, user: action.user
    when 'COLLECTIONS/APPS' then merge state, apps: action.apps
    when 'COLLECTIONS/INSTANCES' then merge state, instances: action.instances
    when 'COLLECTIONS/BUCKETS' then merge state, buckets: action.buckets
    when 'COLLECTIONS/DATASTORE' then merge state, dataStore: action.dataStore
    else state
