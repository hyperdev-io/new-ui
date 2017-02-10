React = require 'react'
Page  = require '../Page.cjsx'
{ LoginForm, Box, Headline }     = require 'grommet'

module.exports  = React.createClass
  displayName: 'Page'

  onSubmit: (credentials) ->
    @props.onLogin credentials.username, credentials.password

  render: ->
    <Box align='center' pad='large' alignContent='center'>
      {if @props.isLoggedIn
        <Headline>Welcome, {@props.userFirstname}</Headline>
      else
        <LoginForm onSubmit={@onSubmit}
          primary=true
          logo={<img src='/logo-140.png' className='loginLogo' />}
          rememberMe={false}
          usernameType='text' />
      }
    </Box>
