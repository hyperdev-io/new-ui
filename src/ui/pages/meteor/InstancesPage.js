var connect, mapStateToProps;

({connect} = require('react-redux'));

mapStateToProps = function(state) {
  return {
    instances: state.collections.instances || []
  };
};

module.exports = connect(mapStateToProps)(require('../InstancesPage'));
