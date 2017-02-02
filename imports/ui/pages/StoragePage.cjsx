{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, List, ListItem, Split } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
DataBucketsList     = require '../lists/DataBucketsList.cjsx'

module.exports = React.createClass
  displayName: 'StoragePage'

  render: ->
    ds = @props.dataStore
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <Article>
      <Header fixed=true pad='medium'>
        <Title responsive=true truncate=true>Storage Buckets</Title>
        <Search onDOMChange={@userSearch} placeHolder='Search...' inline=true fill=true size='medium' />
      </Header>
      <Box align='center' justify='center' direction='row'>
        <DataStoreUsageMeter used={ds.used} free={ds.free} />
      </Box>
      <DataBucketsList buckets={@props.buckets} />
    </Article>
