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
    splitFlex = if @props.selectedAppName then 'right' else 'left'

    console.log 'filesize!', (filesize 103872987136, {output: "object"})
    # data = [{"label": "First", "value": 40, "colorIndex": "graph-1"}, {"label": "Second", "value": 30, "colorIndex": "accent-2"}, {"label": "Third", "value": 20, "colorIndex": "unset"}, {"label": "bla", "value": 23, "colorIndex": "graph-1"}]
    data = @props.buckets.map (b) -> label: b.name, value: filesize(b.size, exponent:exponent, output: 'object').value, colorIndex: 'graph-1'
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
          max={used.value + free.value}
          series={[{"label": "Used", "value": used.value, "colorIndex": "neutral-3"}, {"label": "Free", "value": free.value, "colorIndex": "neutral-4"}]} />


      </Box>
      <List selectable=true onSelect={@listItemSelected}>
        {@props.buckets.map (bucket) ->
          <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
            <Box direction='column' pad='none'>
              <strong>{bucket.name}</strong>
              <span>{filesize bucket.size}</span>
            </Box>
          </ListItem>
        }
      </List>
    </Article>
