module.exports =

  withInstance: (instance) ->
    getStateValue: ->
      switch instance.state
        when 'running' then 'ok'
        when 'failing' then 'critical'
        else 'warning'
    getStatusText: ->
      switch instance.state
        when 'running' then instance.state
        when 'failing' then instance.state
        else instance.status
