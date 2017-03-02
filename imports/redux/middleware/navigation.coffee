
module.exports = (browserHistory) -> ({ getState, dispatch }) -> (next) -> (action) ->
  switch action.type
    when 'APP_SELECTED' then browserHistory.push "/apps/#{action.value.name}/#{action.value.version}"
    else next action
