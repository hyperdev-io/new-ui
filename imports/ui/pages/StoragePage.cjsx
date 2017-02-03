{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
DataBucketsList     = require '../lists/DataBucketsList.cjsx'

module.exports = React.createClass
  displayName: 'StoragePage'

  render: ->
    ds = @props.dataStore
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <Split flex='left' priority='left'>
      <Article>
          <Header fixed=true pad='medium' justify='between'>
            <Box justify='left' direction='row'>
              <Title responsive=true truncate=true>Storage Buckets</Title>
              <Search onDOMChange={@userSearch} placeHolder='Search...' flex=true inline=true iconAlign='start' size='medium' />
            </Box>
            <DataStoreUsageMeter used={ds.used} free={ds.free} />
          </Header>
          <Box align='center'></Box>
          <DataBucketsList buckets={@props.buckets} />
      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' justify='center' direction='column'>
          <Header pad='medium' size='large' direction='column'>
            <Title><Icons.Base.Info /></Title>
            <Paragraph align='center'>
              Storage buckets hold the data of the instances.
              Buckets can be copied and deleted.
              This page lists all storage buckets in your data store.
            </Paragraph>
          </Header>

        </Box>
      </Sidebar>
    </Split>
