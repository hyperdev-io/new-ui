{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
AppsList = require '../lists/AppsList.cjsx'
{ Article, Box, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons} = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsPage'

  onSearch: (evt) ->
    @props.onAppSearchEntered evt.srcElement.value

  render: ->
    <Split flex='left' priority='left'>
      <Article>
        <Header fixed=true pad='medium'>
          <Title responsive=true truncate=true>Apps</Title>
          <Search value={@props.appSearchValue} onDOMChange={@onSearch} placeHolder='Search...' inline=true fill=true size='medium' />
        </Header>
        <AppsList apps={@props.apps} onAppNameSelected={@props.onAppNameSelected} />
      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' justify='center' direction='column'>
          <Header pad='medium' size='large' direction='column'>
            <Title><Icons.Base.Info /> Info</Title>
            <Paragraph align='left'>
              This page lists all storage buckets in your data store.
              A storage bucket contains the actual data of an instance.
              Storage buckets can be copied and deleted. When an instance is
              stopped the data bucket remains until it is deleted by a user.
            </Paragraph>
          </Header>
        </Box>
      </Sidebar>
    </Split>
