module.exports =
  goToAppsPage: ->
    type: 'SHOW_APPS_PAGE'
  goToNewAppPage: ->
    type: 'OPEN_NEW_APP_PAGE_REQUEST'
  goToInstanceDetailsPage: (instanceName) ->
    type: 'OpenInstanceDetailPageRequest'
    name: instanceName
