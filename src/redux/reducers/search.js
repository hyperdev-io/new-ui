var merge;

({merge} = require('./utils'));

module.exports = function(state = {}, action) {
  switch (action.type) {
    case 'APP_SEARCH_CHANGED':
      return merge(state, {
        app_search: action.value
      });
    case 'BUCKET_SEARCH_CHANGED':
      return merge(state, {
        bucket_search: action.value
      });
    case 'APPSTORE_SEARCH_CHANGED':
      return merge(state, {
        appstore_search: action.value
      });
    default:
      return state;
  }
};
