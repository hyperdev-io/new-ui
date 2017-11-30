React         = require 'react'
_             = require 'lodash'
moment        = require 'moment'
DetailPage    = require '../DetailPage.cjsx'
Helpers       = require '../Helpers.coffee'
{PrismCode}   = require 'react-prism'
ansi_up       = require('ansi_up')

{ Anchor, Box, Header, Split, Sidebar, Notification, Section, List, ListItem, Heading, Menu, Button, Icons, Paragraph, Layer } = require 'grommet'

Loading          = require '../Loading.cjsx'
LogsLayer        = require '../layers/LogsLayer.cjsx'
{ Terminal }     = require '../Terminal.jsx'


module.exports = React.createClass
  displayName: 'ServiceLogPage'

  render: ->
    if @props.notFound
      <Box align='center' textAlign='center' alignContent='center' direction='column' full={true} justify='center'>
        <Box width=150>
          <h1>Instance not found...</h1>
          <Paragraph size='large'>Probably this instance was just terminated. Anyhow, it doesn&#39;t exist anymore.</Paragraph>
          <Box align='center' colorIndex='light-3' pad='medium'>
            <Button
              label='Take me to the instances'
              primary={true}
              path='/instances' />
          </Box>
        </Box>
      </Box>
    else @renderWithData()

  renderWithData: ->
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Box pad='medium' style={backgroundColor: 'black'}>
          {@props.log?.map (line, i) ->
            <pre key={i} style={whiteSpace: 'pre-line'}>{line}</pre>
          }
        </Box>
      </DetailPage>
    </Split>
