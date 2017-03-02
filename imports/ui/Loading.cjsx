React = require 'react'
{ Box, Icons } = require 'grommet'
Spinner = require('react-spinkit')


module.exports  = React.createClass
  displayName: 'Loading'

  render: ->
    if @props.isLoading
      <Box align='center' flex=true full=true justify='center'>
        <Spinner spinnerName='rotating-plane' />
      </Box>
    else @props.render()
