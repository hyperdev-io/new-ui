{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
filesize            = require 'filesize'

{ Box, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons, ListItem } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
FilterableListPage  = require '../FilterableListPage.cjsx'

module.exports = React.createClass
  displayName: 'StoragePage'

  renderBucket: (bucket) ->
    <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
      <Box direction='column' pad='none'>
        <span style={fontSize:20}>{bucket.name}</span>
      </Box>
      <Box direction='row' pad='none'>
        <span>{filesize bucket.size or 0}</span>
      </Box>
    </ListItem>

  render: ->
    ds = @props.dataStore
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <Split flex='left' priority='left'>
      <FilterableListPage title='Storage'
        searchValue={@props.searchValue}
        totalResults={@props.totalResults}
        items={@props.buckets}
        onSearch={@props.onBucketSearchChanged}
        onClearSearch={@props.onClearSearch}
        onListItemSelected={@props.onAppNameSelected}
        renderItem={@renderBucket}/>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' justify='center' direction='column'>

          <div style={boxShadhow: '0 4px 8px 0 rgba(0,0,0,0.2)', margin:20, backgroundColor: 'white'}>
          <Header pad='medium' size='large' direction='column'>
            <Title><Icons.Base.Info /> Info</Title>
            <Paragraph align='start'>
              This page lists all storage buckets in your data store.
              A storage bucket contains the actual data of an instance.
              Storage buckets can be copied and deleted. When an instance is
              stopped the data bucket remains until it is deleted by a user.
            </Paragraph>
          </Header>
          </div>

          <Box flex={true} align='center' justify='center' direction='column' style={boxShadhow: '0 4px 8px 0 rgba(0,0,0,0.2)', margin:20, backgroundColor: 'white'}>
          <DataStoreUsageMeter used={ds.used} free={ds.free} />
          </Box>

        </Box>
      </Sidebar>
    </Split>
