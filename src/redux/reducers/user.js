const { merge } = require('./utils');

export default (state = {}, action) => {
  switch (action.type) {
    case 'USER_TOKEN_RECEIVED':
      return merge(state, {
        token: action.token,
        authenticationFailed: false
      })
    case 'USER_AUTHENTICATION_FAILED':
      return merge(state, {
        token: undefined,
        authenticationFailed: true
      })
  }
  return state;
}