{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
{ Link }            = require 'react-router'
{ createContainer } = require 'meteor/react-meteor-data'

G     = require 'grommet'
console.log 'grommet', G

App = React.createClass
  displayName: 'App'

  getInitialState: ->
    priority: 'right'

  switchSideBar: ->
    @setState priority: (if @state.priority is 'right' then 'left' else 'right')

  onErrorToastClose: -> @props.route.App.emit 'clear error message'
  onInfoToastClose: -> @props.route.App.emit 'clear info message'

  render: ->
    console.log 'wie', @props.route.App.state.globalErrorMessage()
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
      {if errorMessage = @props.errorMessage
        <G.Toast status='critical' onClose={@onErrorToastClose}>
          {errorMessage}
        </G.Toast>
      }
      {if infoMessage = @props.infoMessage
        <G.Toast status='ok' onClose={@onInfoToastClose}>
          {infoMessage}
        </G.Toast>
      }
    </G.App>

module.exports = createContainer (props) ->
  errorMessage: props.route.App.state.globalErrorMessage()
  infoMessage: props.route.App.state.globalInfoMessage()
, App
