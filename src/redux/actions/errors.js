module.exports = {
  userError: function(err) {
    return {
      type: 'USER_ERROR',
      err: err
    };
  },
  userErrorAcknowledged: function() {
    return {
      type: 'USER_ERROR_ACK'
    };
  }
};
