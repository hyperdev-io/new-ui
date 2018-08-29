module.exports = {
  saveAppRequest: function(app, dockerCompose, bigboatCompose) {
    return {
      type: 'SAVE_APP_REQUEST',
      app: app,
      dockerCompose: dockerCompose,
      bigboatCompose: bigboatCompose
    };
  },
  startAppRequest: function(appName, version, instanceName) {
    return {
      type: 'START_APP_REQUEST',
      app: {
        name: appName,
        version: version
      },
      instanceName: instanceName
    };
  },
  removeAppRequest: function(app) {
    return {
      type: 'REMOVE_APP_REQUEST',
      app: app
    };
  },
  startAppFormRequest: function(app, defaultName) {
    return {
      type: 'START_APP_FORM_REQUEST',
      app: app,
      params: { name: defaultName }
    };
  },
  appSelected: function(name, version) {
    return {
      type: 'APP_SELECTED',
      value: {
        name: name,
        version: version
      }
    };
  }
};
