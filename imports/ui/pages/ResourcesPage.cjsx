{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
DataBucketsList     = require '../lists/DataBucketsList.cjsx'
Loading             = require '../Loading.cjsx'

module.exports = React.createClass
  displayName: 'ResourcesPage'

  render: ->
    <Loading isLoading={@props.isLoading} render={@renderWithData} />

  renderWithData: ->
    ds = @props.dataStore

    <Split flex='left' priority='left'>
      <Article>
          <Header fixed=true pad='medium' justify='between'>
            <Box justify='start' direction='row'>
              <Title responsive=true truncate=true>Resources Overview</Title>
            </Box>
          </Header>
          <Box align='center'>Hello</Box>
      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' justify='center' direction='column'>
          <Header pad='medium' size='large' direction='column'>
            <Title><Icons.Base.Info /></Title>
            <Paragraph align='center'>
              This page shows the available resources available.
            </Paragraph>
          </Header>

        </Box>
      </Sidebar>
    </Split>
