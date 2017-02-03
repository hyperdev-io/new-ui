React               = require 'react'
filesize            = require 'filesize'
moment              = require 'moment'
{Box, List, ListItem } = require 'grommet'


module.exports = React.createClass
  displayName: 'DataBucketsList'

  listItemSelected: (idx) ->
    console.log 'data bucket selected', @props.buckets[idx]

  render: ->
    #Created {moment(bucket.created).fromNow()}
    <List selectable=true onSelect={@listItemSelected}>
      {@props.buckets.map (bucket) ->
        <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
          <Box direction='column' pad='none'>
            <span style={fontSize:20}>{bucket.name}</span>
          </Box>
          <Box direction='row' pad='none'>
            <span>{filesize bucket.size or 0}</span>
          </Box>
        </ListItem>
      }
    </List>
