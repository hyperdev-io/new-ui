{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
DataBucketsList     = require '../lists/DataBucketsList.cjsx'

module.exports = React.createClass
  displayName: 'StoragePage'

  render: ->
    ds = @props.dataStore
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <Split flex='left' priority='left'>
      <Article>
          <Header fixed=true pad='medium'>
            <Title responsive=true truncate=true>Storage Buckets</Title>
            <Search onDOMChange={@userSearch} placeHolder='Search...' inline=true fill=true size='medium' />
          </Header>
          <DataBucketsList buckets={@props.buckets} />
      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' justify='center' direction='column'>
          <Header pad='medium' size='large' direction='column'>
            <Title>Data Store</Title>
            <Paragraph align='center'>
              Overall storage capacity for the storage buckets.
            </Paragraph>
          </Header>
          <DataStoreUsageMeter used={ds.used} free={ds.free} />
        </Box>
      </Sidebar>
    </Split>
