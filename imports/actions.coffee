module.exports =
  appSearchChanged: (value) ->
    type: 'APP_SEARCH_CHANGED'
    value: value
  appSelected: (name, version) ->
    type: 'APP_SELECTED'
    value:
      name: name
      version: version
