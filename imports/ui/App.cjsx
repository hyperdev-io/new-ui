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
            <G.Header size='large' justify='between'>
            <img src='/logo-140.png' />
            </G.Header>
          </G.Box>
          <G.Menu fill=true primary=true direction='column'>
            <G.Anchor path='/apps'>Apps</G.Anchor>
            <G.Anchor path='/instances'>Instances</G.Anchor>
            <G.Anchor path='/storage'>Storage</G.Anchor>
            <G.Anchor path='/appstore'>App Store</G.Anchor>
          </G.Menu>
          <G.Footer pad={horizontal: 'medium', vertical: 'small'} align='center' direction='row'>
            <G.Menu icon={<G.Icons.Base.User />} size='small' dropAlign={bottom: 'bottom'} colorIndex='neutral-1-a'>
              <G.Anchor>Events</G.Anchor>
              <G.Anchor>Configuration</G.Anchor>
              <G.Anchor>Docs</G.Anchor>
              <G.Anchor>Log out</G.Anchor>
            </G.Menu>
          </G.Footer>
        </G.Sidebar>
        {@props.children}
      </G.Split>
    </G.App>
