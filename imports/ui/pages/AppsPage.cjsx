{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Box, List, ListItem } = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsPage'

  listItemSelected: (a,b,c) ->
    console.log @, a,b,c

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
