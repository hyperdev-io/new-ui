const tokenReceivedType = 'USER_TOKEN_RECEIVED';
const userLogoutRequestType = 'USER_LOGOUT_REQUEST';

module.exports = {
  tokenReceivedType,
  userLogoutRequestType,
  logout: function() {
    return {
      type: userLogoutRequestType
    };
  },
  tokenReceived: token => ({
    type: tokenReceivedType,
    token
  }),
  authenticationFailed: () => ({
    type: 'USER_AUTHENTICATION_FAILED'
  }),
};
