{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
AppsList = require '../lists/AppsList.cjsx'
{ Article, Button, Box, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons, Menu} = require 'grommet'
FilterControl = require 'grommet-addons/components/FilterControl'

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
          <FilterControl unfilteredTotal={@props.results.total} filteredTotal={@props.results.filtered} onClick={@props.clearSearch} />
        </Header>
        <AppsList apps={@props.apps} onAppNameSelected={@props.onAppNameSelected} />
        {if @props.appSearchValue?.length > 0
          <Box textAlign='center' pad='large'>
            This list is filtered by <strong>&ldquo;{@props.appSearchValue}&rdquo;</strong>
          </Box>
        }
      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' direction='column'>
        </Header>
        <Menu pad='medium'>
          <Button onClick={@props.onNewAppClicked} align='start' plain=true label='New App' icon={<Icons.Base.New />}></Button>
        </Menu>
      </Sidebar>
    </Split>
