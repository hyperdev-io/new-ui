var merge;

({merge} = require('./utils'));

module.exports = function(state = {}, action) {
  switch (action.type) {
    case 'USER_ERROR':
      return merge(state, {
        message: `${action.err}`
      });
    case 'USER_ERROR_ACK':
      return merge(state, {
        message: null
      });
    default:
      return state;
  }
};
