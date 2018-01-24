var _, connect, goToInstanceDetailsPage, mapDispatchToProps, mapStateToProps, mergeProps;

_ = require('lodash');

({connect} = require('react-redux'));

({ goToInstanceDetailsPage } = require("../../../redux/actions/navigation"));

mapStateToProps = function(state, {params}) {
  var instance, startByUser;
  instance = _.find(state.collections.instances, {
    name: params.name
  });
  startByUser = _.find(state.collections.users, {
    _id: instance != null ? instance.startedBy : void 0
  });
  return {
    title: `${params.name}.${params.service}`,
    showLogs: params.type === 'logs',
    log: state.collections.log
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onLogClose: function(name) {
      return dispatch(goToInstanceDetailsPage(name));
    }
  };
};

mergeProps = function(stateProps, dispatchProps, ownProps) {
  return Object.assign({}, stateProps, dispatchProps, ownProps, {
    onLogClose: function() {
      return dispatchProps.onLogClose(stateProps.instance.name);
    }
  });
};

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps)(require('../ServiceLogPage'));
