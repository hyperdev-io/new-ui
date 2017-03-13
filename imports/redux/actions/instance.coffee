module.exports =
  stopInstanceRequest: (instanceName) ->
    type: 'StopInstanceRequest'
    instanceName: instanceName
