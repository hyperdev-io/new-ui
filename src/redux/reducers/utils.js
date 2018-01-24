module.exports = {
  merge: function(state, stateDiff) {
    return Object.assign({}, state, stateDiff);
  }
};
