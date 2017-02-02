{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
filesize            = require 'filesize'

{ Article, Box, Header, Heading, Search, Title, Box, List, ListItem, Split, Distribution } = require 'grommet'

AnnotatedMeter = require 'grommet-addons/components/AnnotatedMeter'

module.exports = React.createClass
  displayName: 'StoragePage'

  # getInitialState: ->
  #   splitFlex: 'left'
  #
  # listItemSelected: (idx) ->
  #   @props.appNameSelected @props.appNames[idx]
  #
  # userSearch: (evt) ->
  #   @props.appsSearchEntered evt.srcElement.value

  render: ->
    ds = @props.dataStore

    exponent = filesize ds.total, output: 'exponent'
    used = filesize(ds.used, {output: "object", exponent: exponent})
    free = filesize(ds.free, {output: "object", exponent: exponent})
    usedVal = Math.round used.value
    freeVal = Math.round free.value
    total = Math.round used.value + free.value
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    <Article>
      <Header fixed=true pad='medium'>
        <Title responsive=true truncate=true>Storage Buckets</Title>
        <Search onDOMChange={@userSearch} placeHolder='Search...' inline=true fill=true size='medium' />
      </Header>
      <Box align='center' justify='center' direction='row'>
        <AnnotatedMeter legend={true}
          type='circle'
          size='small'
          units={used.suffix}
          max={total}
          series={[{"label": "Used", "value": usedVal, "colorIndex": "neutral-3"}, {"label": "Free", "value": freeVal, "colorIndex": "unset"}]} />


      </Box>
      <List selectable=true onSelect={@listItemSelected}>
        {@props.buckets.map (bucket) ->
          <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
            <Box direction='column' pad='none'>
              <strong>{bucket.name}</strong>
              <span>{filesize bucket.size or 0}</span>
            </Box>
          </ListItem>
        }
      </List>
    </Article>
