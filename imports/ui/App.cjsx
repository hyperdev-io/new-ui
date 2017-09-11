{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
{ Link }            = require 'react-router'
# { createContainer } = require 'meteor/react-meteor-data'
Notifications       = require './Notifications.cjsx'
{ connect }         = require 'react-redux'


G     = require 'grommet'
{ Button, Icons } = G
console.log 'grommet', G

App = React.createClass
  displayName: 'App'

  getInitialState: ->
    priority: 'right'

  switchSideBar: ->
    @setState priority: (if @state.priority is 'right' then 'left' else 'right')

  render: ->
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
            <G.Anchor path='/resources'>Resources</G.Anchor>
            <G.Anchor path='/appstore'>App Store</G.Anchor>
          </G.Menu>
          <G.Footer pad={horizontal: 'medium', vertical: 'small'} align='center' direction='row'>
            {if @props.isLoggedIn
              <Button align='start' plain=true onClick={@props.onLogout} icon={<Icons.Base.Logout />}></Button>
            else
              <Button align='start' plain=true path='/login' icon={<Icons.Base.Login />}></Button>
            }
            <Button align='start' plain=true icon={<Icons.Base.Configure />}></Button>
            <Button align='start' plain=true icon={<Icons.Base.Document />}></Button>
          </G.Footer>
        </G.Sidebar>
        {@props.children}
      </G.Split>
      {if errorMessage = @props.errorMessage
        <G.Toast status='critical' onClose={@props.onErrorToastClose}>
          {errorMessage}
        </G.Toast>
      }
      {if infoMessage = @props.infoMessage
        <G.Toast status='ok' onClose={@onInfoToastClose}>
          {infoMessage}
        </G.Toast>
      }
      <Notifications />
    </G.App>

{userErrorAcknowledged} = require '/imports/redux/actions/errors.coffee'
{logout} = require '/imports/redux/actions/user.coffee'

mapStateToProps = (state) ->
  errorMessage: state.error?.message
  infoMessage: null
  isLoggedIn: state.collections.user?

mapDispatchToProps = (dispatch) ->
  onErrorToastClose: -> dispatch userErrorAcknowledged()
  onLogout: -> dispatch logout()

module.exports = connect(mapStateToProps, mapDispatchToProps) App

# module.exports = createContainer (props) ->
#   errorMessage: props..globalErrorMessage()
#   infoMessage: props.route.App.state.globalInfoMessage()
#   isLoggedIn: props.route.App.state.isLoggedIn()
# , App
