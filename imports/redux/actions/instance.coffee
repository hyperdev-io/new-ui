module.exports =
  stopInstanceRequest: (instanceName) ->
    type: 'StopInstanceRequest'
    instanceName: instanceName
  getServiceLogsRequest: (cid) ->
    type: 'GetServiceLogsRequest'
    cid: cid
