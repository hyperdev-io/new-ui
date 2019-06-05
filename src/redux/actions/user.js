const userLogoutRequestType = 'USER_LOGOUT_REQUEST';

module.exports = {
  userLogoutRequestType,
  logout: function() {
    return {
      type: userLogoutRequestType
    };
  },
};
