module.exports = (error) ->

  msg = null

  if error.errorType is 'Meteor.Error'
    msg = switch error.error
      when '403' then 'You are not authorized to perform this action.'

  unless msg
    if error.message
      msg = error.message
    else msg = "#{error}"

  msg
