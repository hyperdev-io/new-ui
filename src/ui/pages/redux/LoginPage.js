const { connect } = require('react-redux');
const { loginRequest } = require("../../../redux/actions/auth");

const mapStateToProps = state => ({
  authenticationFailed: state.user && state.user.authenticationFailed,
});
const mapDispatchToProps = dispatch => ({
  onLogin: function(username, password) {
    return dispatch(loginRequest(username, password));
  }
});

module.exports = connect(mapStateToProps, mapDispatchToProps)(require('../LoginPage'));
