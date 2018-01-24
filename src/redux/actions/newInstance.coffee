module.exports =
  newInstancePageCloseRequest: (name, version)->
    type: 'NewInstancePageCloseRequest'
    app:
      name: name
      version: version
