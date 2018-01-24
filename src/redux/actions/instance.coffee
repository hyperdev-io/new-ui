module.exports =
  stopInstanceRequest: (instanceName) ->
    type: 'StopInstanceRequest'
    instanceName: instanceName
  getServiceLogsRequest: (params) ->
    type: 'GetServiceLogsRequest'
    instance: params.name
    service: params.service
