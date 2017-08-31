#
# Redux middleware that implements navigation to urls upon certain actions
#

generateNewInstanceUrl = (action) ->
  url = "/instance/new/#{action.app.name}/#{action.app.version}"
  query = (for key,val of action.params when val?
    "#{key}=#{val}").join '&'
  [url, query].join '?'

replaceOnLocationMatch = (browserHistory, locationMatch, url) ->
  (if browserHistory.getCurrentLocation()?.pathname?.match locationMatch
    browserHistory.replace
  else browserHistory.push) url

module.exports = (browserHistory) -> ({ getState, dispatch }) -> (next) -> (action) ->
  switch action.type
    when 'APP_SELECTED' then browserHistory.push "/apps/#{action.value.name}/#{action.value.version}"
    when 'SHOW_APPS_PAGE' then browserHistory.replace "/apps"
    when 'OPEN_NEW_APP_PAGE_REQUEST' then browserHistory.push "/apps/new"
    when 'START_APP_FORM_REQUEST' then replaceOnLocationMatch browserHistory, "^/instance/new", generateNewInstanceUrl action
    when 'NewInstancePageCloseRequest' then browserHistory.push "/apps/#{action.app.name}/#{action.app.version}"
    when 'OpenBucketPageRequest' then browserHistory.push "/storage/#{action.name}"
    else next action
