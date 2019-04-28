import InstancesPage from '../InstancesPage';
var connect, mapStateToProps;

({connect} = require('react-redux'));

mapStateToProps = function(state) {
  return {
    instances: state.collections.instances || []
  };
};

export default connect(mapStateToProps)(InstancesPage);
