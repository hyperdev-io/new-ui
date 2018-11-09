const loginRequestType = 'LoginRequest';

module.exports = {
  loginRequestType,
  loginRequest: function(username, password) {
    return {
      type: loginRequestType,
      username: username,
      password: password
    };
  }
};
