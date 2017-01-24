{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
{ Link }            = require 'react-router'

G     = require 'grommet'
console.log 'grommet', G

module.exports = App = React.createClass
  displayName: 'App'

  getInitialState: ->
    priority: 'right'

  switchSideBar: ->
    @setState priority: (if @state.priority is 'right' then 'left' else 'right')

  render: ->
    console.log G.Split
    <G.App centered=false>
      <G.Split flex='right' priority={@state.priority}>
        <G.Sidebar colorIndex='neutral-1'>
          <G.Box align='center'>
            <G.Header size='large' justify='between'><G.Title responsive=true>Big Boat</G.Title></G.Header>
          </G.Box>
          <G.Menu fill=true primary=true direction='column'>
            <G.Anchor path='/apps'>Apps</G.Anchor>
            <G.Anchor path='/instances'>Instances</G.Anchor>
            <G.Anchor path='/storage'>Storage</G.Anchor>
            <G.Anchor path='/appstore'>App Store</G.Anchor>
          </G.Menu>
        </G.Sidebar>
        {@props.children}
      </G.Split>
    </G.App>
