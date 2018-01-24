var connect, loginRequest, mapDispatchToProps, mapStateToProps;

({connect} = require('react-redux'));

({ loginRequest } = require("../../../redux/actions/auth"));

mapStateToProps = function(state) {
  var user;
  user = state.collections.user;
  return {
    isLoggedIn: user != null,
    userFirstname: user != null ? user.profile.firstname : void 0
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onLogin: function(username, password) {
      return dispatch(loginRequest(username, password));
    }
  };
};

module.exports = connect(mapStateToProps, mapDispatchToProps)(require('../LoginPage'));
