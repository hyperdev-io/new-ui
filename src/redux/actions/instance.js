module.exports = {
  stopInstanceRequest: function(instanceName) {
    return {
      type: 'StopInstanceRequest',
      instanceName: instanceName
    };
  },
  getServiceLogs: function(params) {
    return {
      type: 'GetServiceLogs',
      instance: params.name,
      service: params.service
    };
  }
};
