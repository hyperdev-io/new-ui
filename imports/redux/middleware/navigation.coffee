
module.exports = (browserHistory) -> ({ getState, dispatch }) -> (next) -> (action) ->
  switch action.type
    when 'APP_SELECTED' then browserHistory.push "/apps/#{action.value.name}/#{action.value.version}"
    when 'START_APP_REQUEST' then browserHistory.push "/instance/new/#{action.app.name}/#{action.app.version}" 
    else next action
