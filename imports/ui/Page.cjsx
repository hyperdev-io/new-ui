React = require 'react'
G     = require 'grommet'

module.exports  = React.createClass
  displayName: 'Page'

  render: ->
    <G.Article>
      <G.Header fixed=true pad='medium'>
        <G.Title responsive=true flex='grow'>{@props.route.title}</G.Title>

        <G.Menu inline=false direction='column' label="Menu" size='small' dropAlign={top: 'top', right: 'right'}>
          <G.Anchor>Events</G.Anchor>
          <G.Anchor>Configuration</G.Anchor>
          <G.Anchor>Docs</G.Anchor>
          <G.Anchor>Log out</G.Anchor>
        </G.Menu>


      </G.Header>

      {@props.children}

    </G.Article>
