{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, List, ListItem, Split } = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsPage'

  getInitialState: ->
    splitFlex: 'left'

  listItemSelected: (idx) ->
    @props.appNameSelected @props.appNames[idx]

  userSearch: (evt) ->
    @props.appsSearchEntered evt.srcElement.value

  render: ->
    splitFlex = if @props.selectedAppName then 'right' else 'left'
    <Article>
      <Header fixed=true pad='medium'>
        <Title responsive=true truncate=true>Apps</Title>
        <Search onDOMChange={@userSearch} placeHolder='Search...' inline=true fill=true size='medium' />
      </Header>
      <List selectable=true onSelect={@listItemSelected}>
        {@props.appNames.map (app) ->
          <ListItem key={app._id} pad='medium' justify='between' align='center'>
            <Box direction='column' pad='none'>
              <strong>{app.name}</strong>
              <span>{app.version}</span>
            </Box>
          </ListItem>
        }
      </List>
    </Article>
