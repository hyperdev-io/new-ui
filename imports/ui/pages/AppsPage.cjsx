{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
AppsList = require '../lists/AppsList.cjsx'
{ Article, Button, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons, Menu} = require 'grommet'

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
        <Header pad='medium' size='large' direction='column'>
        </Header>
        <Menu pad='medium'>
          <Button onClick={@props.onNewAppClicked} align='start' plain=true label='New App' icon={<Icons.Base.New />}></Button>
        </Menu>
      </Sidebar>
    </Split>
