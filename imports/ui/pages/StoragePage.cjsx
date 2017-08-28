{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
DataBucketsList     = require '../lists/DataBucketsList.cjsx'
Loading             = require '../Loading.cjsx'

module.exports = React.createClass
  displayName: 'StoragePage'

  render: ->
    <Loading isLoading={@props.isLoading} render={@renderWithData} />

  renderWithData: ->
    ds = @props.dataStore
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <Split flex='left' priority='left'>
      <Article>
          <Header fixed=true pad='medium' justify='between'>
            <Box justify='start' direction='row'>
              <Title responsive=true truncate=true>Storage Buckets</Title>
              <Search onDOMChange={@userSearch} placeHolder='Search...' inline=true iconAlign='start' size='medium' />
            </Box>
          </Header>
          <Box align='center'></Box>
          <DataBucketsList buckets={@props.buckets} selectedBucket={@props.selectedBucket}/>
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
            <DataStoreUsageMeter used={ds.used} free={ds.free} />
          </Header>

        </Box>
      </Sidebar>
    </Split>
