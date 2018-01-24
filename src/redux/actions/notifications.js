var info, notification, reactNotify, success, warning;

reactNotify = require('react-notification-system-redux');

({info, success, warning} = reactNotify);

notification = function(title, message) {
  return {
    title: title,
    message: message,
    position: 'tr',
    autoDismiss: 5
  };
};

module.exports = {
  instanceRunningNotification: function(instance) {
    return success(notification('Instance has started', `Instance ${instance.name} has been successfully started.`));
  },
  instanceStoppingNotification: function(instance) {
    return warning(notification('Instance is stopping', `Instance ${instance.name} is stopping.`));
  },
  instanceStopRequestedNotification: function(instanceName) {
    return info(notification('Instance stop requested', `Instance ${instanceName} stop has been requested.`));
  },
  instanceStartedNotification: function(instance) {
    return success(notification('Instance is starting!', `Instance ${instance.name} is starting.`));
  },
  instanceStoppedNotification: function(instance) {
    return warning(notification('Instance has stopped!', `Instance ${instance.name} has been successfully stopped.`));
  },
  appSavedNotification: function(app) {
    return success(notification('App successfully saved!', `App ${app.name}:${app.version} is saved.`));
  },
  appRemovedNotification: function(app) {
    return warning(notification('App successfully removed!', `App ${app.name}:${app.version} is removed.`));
  },
  copyBucketRequestedNotification: function(from, to) {
    return info(notification('Copy bucket requested', `The contents of ${from} will be copied to ${to}.`));
  },
  deleteBucketRequestedNotification: function(bucket) {
    return info(notification('Removal of bucket requested', `Data bucket ${bucket} will be removed.`));
  }
};
