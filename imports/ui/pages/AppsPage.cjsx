{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Header, Search, Title, Box, List, ListItem } = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsPage'

  listItemSelected: (a,b,c) ->
    console.log @, a,b,c

  render: ->
    <Article>
      <Header fixed=true pad='medium'>
        <Title responsive=true truncate=true>Apps</Title>
        <Search placeHolder='Search...' inline=true fill=true size='medium' />
      </Header>

      <List selectable=true onSelect={@listItemSelected}>
        {@props.appNames.map (app) ->
          <ListItem key={app} pad='medium' justify='between' align='center'>
            <Box direction='column' pad='none'>
              <strong>{app}</strong>
              <span>-</span>
            </Box>
          </ListItem>
        }
      </List>
    </Article>
