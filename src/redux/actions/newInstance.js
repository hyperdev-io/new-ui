module.exports = {
  newInstancePageCloseRequest: function(name, version) {
    return {
      type: 'NewInstancePageCloseRequest',
      app: {
        name: name,
        version: version
      }
    };
  }
};
