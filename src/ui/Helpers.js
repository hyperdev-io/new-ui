module.exports = {
  withInstance: function(instance) {
    return {
      getStateValue: function() {
        switch (instance.state) {
          case 'running':
            return 'ok';
          case 'failing':
            return 'critical';
          default:
            return 'warning';
        }
      },
      getStatusText: function() {
        switch (instance.state) {
          case 'running':
            return instance.state;
          case 'failing':
            return instance.state;
          default:
            return instance.status;
        }
      }
    };
  }
};
