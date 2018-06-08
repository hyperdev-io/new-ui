const _ = require("lodash");
const { connect } = require("react-redux");

const sortByState = function(services = []) {
  return _.sortBy(services, ["isUp"]);
};

const mapStateToProps = function(state, { params }) {
  var services;
  return {
    resources: state.collections.resources || {compute: [], storage: []},
    isLoading: !state.collections.resources
  };
};

module.exports = connect(mapStateToProps)(require("../ResourcesPage"));
