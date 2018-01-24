module.exports = {
  stopInstanceRequest: function(instanceName) {
    return {
      type: 'StopInstanceRequest',
      instanceName: instanceName
    };
  },
  getServiceLogsRequest: function(params) {
    return {
      type: 'GetServiceLogsRequest',
      instance: params.name,
      service: params.service
    };
  }
};
