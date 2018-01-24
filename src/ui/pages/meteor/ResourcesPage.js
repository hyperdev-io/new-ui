var _, connect, mapStateToProps, pretty, sortByState;

_ = require('lodash');

pretty = require('prettysize');

({connect} = require('react-redux'));

sortByState = function(services = []) {
  return _.sortBy(services, ['isUp']);
};

mapStateToProps = function(state, {params}) {
  var services;
  return {
    services: services = sortByState(state.collections.services),
    isLoading: services == null
  };
};

module.exports = connect(mapStateToProps)(require('../ResourcesPage'));
