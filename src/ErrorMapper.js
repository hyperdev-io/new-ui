module.exports = function(error) {
  var msg;
  msg = null;
  if (error.errorType === 'Meteor.Error') {
    msg = (function() {
      switch (error.error) {
        case '403':
          return 'You are not authorized to perform this action.';
      }
    })();
  }
  if (!msg) {
    if (error.message) {
      msg = error.message;
    } else {
      msg = `${error}`;
    }
  }
  return msg;
};
