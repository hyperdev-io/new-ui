React                 = require 'react'
filesize              = require 'filesize'
_                     = require 'lodash'

{ Box, Button, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons, ListItem } = require 'grommet'

DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
FilterableListPage  = require '../FilterableListPage.cjsx'
BucketCopyLayer     = require '../layers/BucketCopyLayer.cjsx'
BucketRemoveLayer   = require '../layers/BucketRemoveLayer.cjsx'

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
            <Button path={"/storage/#{bucket.name}/copy"} icon={<Icons.Base.Copy />}/>
            <Button path={"/storage/#{bucket.name}/delete"} icon={<Icons.Base.Trash />} onClick={->console.log 'remove'} />
          </Box>
        else
          <img src='/img/hourglass.svg' style={padding: '0px 35px'} />
        }
      </Box>
    </ListItem>

  render: ->
    ds = @props.dataStore
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <span>
    <Split flex='left' priority='left'>
      <FilterableListPage title='Storage'
        searchValue={@props.searchValue}
        totalResults={@props.totalResults}
        items={@props.buckets}
        selectedIdx={_.findIndex @props.buckets, (b)=> b.name is @props.selectedBucket}
        onSearch={@props.onBucketSearchChanged}
        onClearSearch={@props.onClearSearch}
        onListItemSelected={@props.onAppNameSelected}
        renderItem={@renderBucket}/>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' direction='column'>

          <div style={borderBottom: '1px solid dimgrey', margin:20}>
          <Header pad='medium' align='start' size='large' direction='column'>
            <Paragraph align='start'>
              <Icons.Base.Info style={float:'left', marginTop:10, marginRight:10} />
              This page lists all storage buckets in your data store.
              A storage bucket contains the actual data of an instance.
              Storage buckets can be copied and deleted. When an instance is
              stopped the data bucket remains until it is deleted by a user.
            </Paragraph>
          </Header>
          </div>

          <Box flex={true} justify='center' direction='column'>
            <DataStoreUsageMeter used={ds.used} free={ds.free} />
          </Box>

        </Box>
      </Sidebar>
    </Split>
    <BucketCopyLayer
      hidden={not @props.isCopy}
      selectedBucket={@props.selectedBucket}
      onClose={=> @props.onActionMenuClose @props.selectedBucket}
      onSubmit={@props.onCopy} />
    <BucketRemoveLayer
      hidden={not @props.isDelete}
      selectedBucket={@props.selectedBucket}
      onClose={=> @props.onActionMenuClose @props.selectedBucket}
      onSubmit={@props.onDelete}/>
    </span>
