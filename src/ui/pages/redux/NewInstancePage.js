import NewInstancePage from '../NewInstancePage';

var _, connect, mapDispatchToProps, mapStateToProps, mergeProps, newInstancePageCloseRequest, startAppRequest;

_ = require('lodash');

({connect} = require('react-redux'));

({
  newInstancePageCloseRequest
} = require("../../../redux/actions/newInstance"));

({ startAppRequest } = require("../../../redux/actions/apps"));

mapStateToProps = function(state, {params, location}) {
  var query, ref, ref1, selectedAppName, selectedAppVersion;
  query = location.query;
  selectedAppName = params.name || null;
  selectedAppVersion = params.version || null;
  return {
    apps: (ref = state.collections.apps) != null ? ref.map(function(a) {
      return {
        _id: a._id,
        name: a.name,
        version: a.version || []
      };
    }) : void 0,
    buckets: (ref1 = state.collections.buckets) != null ? ref1.map(function(b) {
      return b.name;
    }) : void 0,
    name: query != null ? query.name : void 0,
    bucket: query != null ? query.bucket : void 0,
    appsearch: query != null ? query.appsearch : void 0,
    selectedApp: _.find(state.collections.apps, {
      name: selectedAppName,
      version: selectedAppVersion
    }),
    selectedAppName: selectedAppName,
    selectedAppVersion: selectedAppVersion,
    stateful: query.stateful!=null ? query.stateful==='true' : true,
    appParams: _.fromPairs(_.filter(_.toPairs(query), function([key]) {
      return key.match("^param_");
    }))
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onStateChanged: function(state) {
      console.log('stateOn',state)
      return dispatch(Object.assign({
        type: 'START_APP_FORM_REQUEST'
      }, state));
    },
    onClose: function(name, version) {
      return dispatch(newInstancePageCloseRequest(name, version));
    },
    onStartInstance: function(appName, version, instanceName, stateful) {
      console.log('stateful', stateful)
      return dispatch(startAppRequest(appName, version, instanceName, stateful));
    }
  };
};

mergeProps = function(stateProps, dispatchProps, ownProps) {
  var state;
  console.log('stateProps',stateProps);
  state = {
    app: {
      name: stateProps.selectedAppName,
      version: stateProps.selectedAppVersion
    },
    params: Object.assign({}, stateProps.appParams, {
      name: stateProps.name,
      bucket: stateProps.bucket,
      appsearch: stateProps.appsearch,
      stateful: stateProps.stateful
    })
  };
  return Object.assign({}, stateProps, dispatchProps, ownProps, {
    onStateChanged: function(stateDiff) {
      return dispatchProps.onStateChanged(Object.assign({}, state, {
        params: Object.assign({}, state.params, stateDiff)
      }));
    },
    onAppSelected: function(name, version) {
      return dispatchProps.onStateChanged(Object.assign({}, state, {
        app: {
          name: name,
          version: version
        }
      }));
    },
    onClose: function() {
      return dispatchProps.onClose(state.app.name, state.app.version);
    },
    onStartInstance: function() {
      console.log('state', state);
      return dispatchProps.onStartInstance(state.app.name, state.app.version, state.params.name, state.params.stateful);
    }
  });
};

export default connect(mapStateToProps, mapDispatchToProps, mergeProps)(NewInstancePage);
