{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
FilterableListPage  = require '../FilterableListPage.cjsx'
AppsList            = require '../lists/AppsList.cjsx'
{ Article, Button, Box, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons, Menu, ListItem} = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsPage'

  renderItem: (app) ->
    <ListItem key={app._id} pad='medium' justify='between' align='center'>
      <Box direction='column' pad='none'>
        <strong>{app.name}</strong>
        <span>{app.version}</span>
      </Box>
    </ListItem>

  render: ->
    <Split flex='left' priority='left'>
      <FilterableListPage title='Apps'
        searchValue={@props.appSearchValue}
        totalResults={@props.totalResults}
        items={@props.items}
        onSearch={@props.onAppSearchEntered}
        onClearSearch={@props.onClearSearch}
        onListItemSelected={@props.onAppNameSelected}
        renderItem={@renderItem}/>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' direction='column'>
        </Header>
        <Menu pad='medium'>
          <Button onClick={@props.onNewAppClicked} align='start' plain=true label='New App' icon={<Icons.Base.New />}></Button>
        </Menu>
      </Sidebar>
    </Split>
