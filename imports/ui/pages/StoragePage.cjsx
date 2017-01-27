{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, List, ListItem, Split } = require 'grommet'

console.log require 'grommet-addons/components/AnnotatedMeter'

module.exports = React.createClass
  displayName: 'StoragePage'

  # getInitialState: ->
  #   splitFlex: 'left'
  #
  # listItemSelected: (idx) ->
  #   @props.appNameSelected @props.appNames[idx]
  #
  # userSearch: (evt) ->
  #   @props.appsSearchEntered evt.srcElement.value

  render: ->
    splitFlex = if @props.selectedAppName then 'right' else 'left'
    <Article>
      <Header fixed=true pad='medium'>
        <Title responsive=true truncate=true>Storage Buckets</Title>
        <Search onDOMChange={@userSearch} placeHolder='Search...' inline=true fill=true size='medium' />
      </Header>
      <List selectable=true onSelect={@listItemSelected}>
        {@props.buckets.map (bucket) ->
          <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
            <Box direction='column' pad='none'>
              <strong>{bucket.name}</strong>
              <span>{bucket.size}</span>
            </Box>
          </ListItem>
        }
      </List>
    </Article>
