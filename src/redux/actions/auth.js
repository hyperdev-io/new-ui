module.exports = {
  loginRequest: function(username, password) {
    return {
      type: 'LoginRequest',
      username: username,
      password: password
    };
  }
};
