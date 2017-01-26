React = require 'react'
G     = require 'grommet'

{ Router, browserHistory } = require 'react-router'

module.exports  = React.createClass
  displayName: 'DetailPage'

  goBack: ->
    browserHistory.goBack()

  render: ->
    <G.Article>
      <G.Header fixed=true pad={vertical: 'small', between: 'small'}>
        <G.Box pad='small'><G.Anchor icon={<G.Icons.Base.LinkPrevious />} onClick={@goBack} /></G.Box>
        <G.Title responsive=true flex='grow'><G.Heading strong=true>{@props.title}</G.Heading></G.Title>
      </G.Header>

      {@props.children}

    </G.Article>
