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
    when 'START_APP_REQUEST' then replaceOnLocationMatch browserHistory, "^/instance/new", generateNewInstanceUrl action
    when 'NewInstancePageCloseRequest' then browserHistory.push "/apps/#{action.app.name}/#{action.app.version}"
    else next action
