{ merge } = require './utils.coffee'

module.exports = (state = {user: null, apps: [], buckets: []}, action) ->
  switch action.type
    when 'COLLECTIONS/USER' then merge state, user: action.user
    when 'COLLECTIONS/APPS' then merge state, apps: action.apps
    when 'COLLECTIONS/INSTANCES' then merge state, instances: action.instances
    when 'COLLECTIONS/BUCKETS' then merge state, buckets: action.buckets
    when 'COLLECTIONS/SERVICES' then merge state, services: action.services
    when 'COLLECTIONS/DATASTORE' then merge state, dataStore: action.dataStore
    when 'COLLECTIONS/USERS' then merge state, users: action.users
    when 'COLLECTIONS/APPSTORE' then merge state, appstore_apps: action.apps
    else state
