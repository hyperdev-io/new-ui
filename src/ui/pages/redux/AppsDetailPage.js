var _, appSelected, appTemplate, connect, mapDispatchToProps, mapStateToProps, mergeProps, removeAppRequest, saveAppRequest, startAppFormRequest;

_ = require('lodash');

({connect} = require('react-redux'));

({
  saveAppRequest,
  removeAppRequest,
  startAppFormRequest,
  appSelected
} = require("../../../redux/actions/apps"));

appTemplate = {
  name: 'MyNewApp',
  version: '1.0',
  dockerCompose: "version: '2.0'\nservices:\n  www:\n    image: nginx",
  bigboatCompose: "name: MyNewApp\nversion: '1.0'"
};

mapStateToProps = function(state, {params}) {
  var app, isNewApp, title;
  if (params.name && params.version) {
    app = _.find(state.collections.apps, {
      name: params.name,
      version: params.version
    });
    title = `${(app != null ? app.name : void 0)}:${(app != null ? app.version : void 0)}`;
    isNewApp = false;
  } else {
    app = appTemplate;
    title = 'New App';
    isNewApp = true;
  }
  return {
    app: app,
    title: title,
    dockerCompose: app != null ? app.dockerCompose : void 0,
    bigboatCompose: app != null ? app.bigboatCompose : void 0,
    isLoading: app == null,
    isNewApp: isNewApp
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onSaveApp: function(app, dockerCompose, bigboatCompose) {
      return dispatch(saveAppRequest(app, dockerCompose, bigboatCompose));
    },
    onRemoveApp: function(app) {
      return dispatch(removeAppRequest(app));
    },
    onStartApp: function(app) {
      return dispatch(startAppFormRequest(app));
    },
    onAppSelected: function(app) {
      return dispatch(appSelected(app.name, app.version));
    }
  };
};

mergeProps = function(stateProps, dispatchProps, ownProps) {
  var app;
  app = stateProps.app;
  return Object.assign({}, stateProps, dispatchProps, ownProps, {
    onSaveApp: function(dockerCompose, bigboatCompose, name, version) {
      app.name = name || app.name;
      app.version = version || app.version;
      dispatchProps.onSaveApp(app, dockerCompose || app.dockerCompose, bigboatCompose || app.bigboatCompose);
      if (stateProps.isNewApp) {
        return dispatchProps.onAppSelected(app);
      }
    },
    onRemoveApp: function() {
      return dispatchProps.onRemoveApp(app);
    },
    onStartApp: function() {
      return dispatchProps.onStartApp(app);
    }
  });
};

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps)(require('../AppsDetailPage'));
