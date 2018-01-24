module.exports = {
  goToAppsPage: function() {
    return {
      type: 'SHOW_APPS_PAGE'
    };
  },
  goToNewAppPage: function() {
    return {
      type: 'OPEN_NEW_APP_PAGE_REQUEST'
    };
  },
  goToInstanceDetailsPage: function(instanceName) {
    return {
      type: 'OpenInstanceDetailPageRequest',
      name: instanceName
    };
  }
};
