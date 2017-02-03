React = require 'react'
{ Box, List, ListItem } = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsList'

  listItemSelected: (idx) ->
    @props.onAppNameSelected @props.apps[idx]

  render: ->
    <List selectable=true onSelect={@listItemSelected}>
      {@props.apps.map (app) ->
        <ListItem key={app._id} pad='medium' justify='between' align='center'>
          <Box direction='column' pad='none'>
            <strong>{app.name}</strong>
            <span>{app.version}</span>
          </Box>
        </ListItem>
      }
    </List>
