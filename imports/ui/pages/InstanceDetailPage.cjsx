React         = require 'react'
# G             = require 'grommet'
_             = require 'lodash'
DetailPage    = require '../DetailPage.cjsx'
Helpers       = require '../Helpers.coffee'
{PrismCode}   = require 'react-prism'
ansi_up       = require('ansi_up')

{ Header, Split, Sidebar, Notification, Section, List, ListItem, Heading, Menu, Button, Icons } = require 'grommet'

InstanceControls = require '../menus/InstanceControls.cjsx'

li = (name, val) ->
  <ListItem justify='between'>
    <span>{name}</span>
    <span className='secondary'>{val}</span>
  </ListItem>

module.exports = React.createClass
  displayName: 'InstanceDetailPage'

  render: ->
    if @props.instance
      @renderWithData()
    else @renderNoData()

  renderNoData: -> <span />

  renderWithData: ->
    instanceHelper = Helpers.withInstance @props.instance
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Notification pad='medium' status={instanceHelper.getStateValue()}
        message={instanceHelper.getStatusText()} />

        <Section pad='medium'>
          <List>
            {li 'Application name', @props.instance.app.name}
            {li 'Application version', @props.instance.app.version}
            {li 'Storage bucket', @props.instance.storageBucket}
          </List>
        </Section>

        <Section pad='medium'>
          <pre>
          <PrismCode className="language-bash">
            {x = @props.instance.logs?.startup?.join('')
            console.log x
            x
            }
          </PrismCode>
          </pre>
        </Section>

        {_.map @props.instance.services, (service, name) ->
          <Section key={name} pad='medium'>
            <Heading tag='h2'>{name}</Heading>
            <List>
              {li 'Created', service.container?.created}
              {li 'State', service.state}
              {li 'FQDN', service.fqdn}
              {li 'Container name', service.container?.name}
              {li 'Ports', service.ports}
              {li 'Network', service.aux?.net?.state}
            </List>
          </Section>
        }
      </DetailPage>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' />
        <InstanceControls instanceName={@props.instance.name} emit={@props.emit} />
      </Sidebar>
    </Split>
