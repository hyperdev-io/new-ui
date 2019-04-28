var merge;

({merge} = require('./utils'));

module.exports = function(state = {
    user: null,
    apps: [],
    buckets: []
  }, action) {
  switch (action.type) {
    case 'USER':
      return merge(state, {
        user: action.payload
      });
    case 'COLLECTIONS/APPS':
      return merge(state, {
        apps: action.apps
      });
    case 'COLLECTIONS/INSTANCES':
      return merge(state, {
        instances: action.instances
      });
    case 'COLLECTIONS/BUCKETS':
      return merge(state, {
        buckets: action.buckets
      });
    case 'COLLECTIONS/SERVICES':
      return merge(state, {
        services: action.services
      });
    case 'COLLECTIONS/DATASTORE':
      return merge(state, {
        dataStore: action.dataStore
      });
    case 'COLLECTIONS/USERS':
      return merge(state, {
        users: action.users
      });
    case 'COLLECTIONS/APPSTORE':
      return merge(state, {
        appstore_apps: action.apps
      });
    case 'COLLECTIONS/RESOURCES':
      const resources = { compute: [], storage: []}
      action.resources.forEach(r => r.__typename === 'ComputeNode' ? resources.compute.push(r) : resources.storage.push(r))
      return merge(state, { resources });
    case 'COLLECTIONS/LOG':
      return merge(state, {
        log: action.log
      });
    default:
      return state;
  }
};
