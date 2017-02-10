React = require 'react'
G     = require 'grommet'

module.exports  = React.createClass
  displayName: 'Page'

  render: ->
    <G.Article>
      <G.Header fixed=true pad='medium'>
        <G.Title responsive=true flex='grow'>{@props.title or @props.route.title}</G.Title>
      </G.Header>

      {@props.children}

    </G.Article>
