{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
filesize            = require 'filesize'

{ Box, Button, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons, ListItem } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
FilterableListPage  = require '../FilterableListPage.cjsx'

module.exports = React.createClass
  displayName: 'StoragePage'

  renderBucket: (bucket) ->
    <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
      <Box direction='column' pad='none'>
        <span style={fontSize:20}>{bucket.name}</span>
      </Box>
      <Box direction='row' pad='none' align='center'>
        <span style={paddingRight:20}>{filesize bucket.size or 0}</span>
        {if not bucket.isLocked
          <Box direction='row' pad='none'>
            <Button icon={<Icons.Base.Copy />} onClick={->console.log 'copy'} />
            <Button icon={<Icons.Base.Trash />} onClick={->console.log 'remove'} />
          </Box>
        else
          <img src='/img/hourglass.svg' style={padding: '0px 35px'} />
        }
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
        <Box align='left' direction='column'>

          <div style={borderBottom: '1px solid dimgrey', margin:20}>
          <Header pad='medium' align='left' size='large' direction='column'>
            <Paragraph align='start'>
              <Icons.Base.Info style={float:'left', marginTop:10, marginRight:10} />
              This page lists all storage buckets in your data store.
              A storage bucket contains the actual data of an instance.
              Storage buckets can be copied and deleted. When an instance is
              stopped the data bucket remains until it is deleted by a user.
            </Paragraph>
          </Header>
          </div>

          <Box flex={true} align='center' justify='center' direction='column'>
            <DataStoreUsageMeter used={ds.used} free={ds.free} />
          </Box>

        </Box>
      </Sidebar>
    </Split>
