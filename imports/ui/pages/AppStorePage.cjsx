{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
FilterControl       = require 'grommet-addons/components/FilterControl'
{ Article, Button, Box, Card, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons, Menu, ListItem} = require 'grommet'
{ Section, Label, Tiles, Tile } = require 'grommet'

module.exports = ({ apps })->
    console.log 'APPS!!', apps

    sortedApps = _.sortBy apps, ['name', 'version']
    groups = _.values _.groupBy sortedApps, (i) -> i.name
    console.log 'groups', groups

    <Split flex='left' priority='left'>
      <Article>
        <Header fixed=true pad='medium'>
          <Title responsive=true truncate=true>App Store</Title>
          <Search value={''} onDOMChange={null} placeHolder='Search...' inline=true fill=true size='medium' />
          <FilterControl unfilteredTotal={10} filteredTotal={0} onClick={null} />
        </Header>

        <Section pad='none'>
          <Tiles selectable=true pad={horizontal:'small'} fill=false flush=false responsive=false>
          {groups?.map (apps) ->
            { _id, name, version, pic} = apps?[apps?.length - 1]
            <Tile key={_id} align='center' pad='small' direction='column' size={width: {min: 'small'}} onClick={null}>
              <div style={height:100}>
                <span style={height:'100%', display:'inline-block', verticalAlign:'middle'}></span>
                <img style={maxHeight: 100, maxWidth: 150, verticalAlign:'middle'} src={pic} />
              </div>
              <Box align='center'>
                <strong>{name}</strong>
                <Box direction='row'>
                  <span className='secondary'>{version}</span>
                </Box>
              </Box>
            </Tile>
          }
          </Tiles>
        </Section>

      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' direction='column'>
        </Header>
      </Sidebar>
    </Split>
