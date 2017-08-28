{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

{ Article, Box, Header, Heading, Search, Title, Box, Split, Sidebar, Paragraph, Icons, List, ListItem } = require 'grommet'
{ Status } = Icons
DataStoreUsageMeter = require '../viz/DataStoreUsageMeter.cjsx'
DataBucketsList     = require '../lists/DataBucketsList.cjsx'
Loading             = require '../Loading.cjsx'

module.exports = React.createClass
  displayName: 'ResourcesPage'

  render: ->
    <Loading isLoading={@props.isLoading} render={@renderWithData} />

  renderWithData: ->
    services = @props.services
    console.log 'services', services
    <Split flex='left' priority='left'>
      <Article>
          <Header fixed=true pad='medium' justify='between'>
            <Box justify='start' direction='row'>
              <Title responsive=true truncate=true>Resources Overview</Title>
            </Box>
          </Header>
          <List>
            {@props.services?.map (service, i) ->
              <ListItem key={i}>
                <Box direction='row' align='center' >
                  <Status value={if service.isUp then 'ok' else 'warning'}/>
                  <Box direction='column' pad='small'>
                    <strong>{service.name}</strong>
                    <span dangerouslySetInnerHTML={__html:service.description}></span>
                  </Box>
                </Box>
              </ListItem>
            }
          </List>
      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Box align='center' justify='center' direction='column'>
          <Header pad='medium' size='large' direction='column'>
            <Title><Icons.Base.Info /></Title>
            <Paragraph align='center'>
              This page lists the availability of all resources and their status.
            </Paragraph>
          </Header>

        </Box>
      </Sidebar>
    </Split>
