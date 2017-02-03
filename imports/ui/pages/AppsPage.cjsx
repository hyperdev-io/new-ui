{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
AppsList = require '../lists/AppsList.cjsx'
{ Article, Box, Header, Heading, Search, Title} = require 'grommet'

module.exports = React.createClass
  displayName: 'AppsPage'

  onSearch: (evt) ->
    @props.onAppSearchEntered evt.srcElement.value

  render: ->
    <Article>
      <Header fixed=true pad='medium'>
        <Title responsive=true truncate=true>Apps</Title>
        <Search value={@props.appSearchValue} onDOMChange={@onSearch} placeHolder='Search...' inline=true fill=true size='medium' />
      </Header>
      <AppsList apps={@props.apps} onAppNameSelected={@props.onAppNameSelected} />
    </Article>
