var connect,
  goToInstanceDetailsPage,
  mapDispatchToProps,
  mapStateToProps,
  mergeProps;

({ connect } = require("react-redux"));

({ goToInstanceDetailsPage } = require("../../../redux/actions/navigation"));

mapStateToProps = function(state, { params }) {
  return {
    title: `${params.name}.${params.service}`,
    showLogs: params.type === "logs",
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

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps)(
  require("../ServiceLogPage")
);
