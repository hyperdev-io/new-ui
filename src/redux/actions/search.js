module.exports = {
  appSearchChanged: function(value) {
    return {
      type: 'APP_SEARCH_CHANGED',
      value: value
    };
  },
  appstoreSearchChanged: function(value) {
    return {
      type: 'APPSTORE_SEARCH_CHANGED',
      value: value
    };
  },
  bucketSearchChanged: function(value) {
    return {
      type: 'BUCKET_SEARCH_CHANGED',
      value: value
    };
  }
};
