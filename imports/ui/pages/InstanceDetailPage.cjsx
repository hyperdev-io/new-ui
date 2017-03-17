React         = require 'react'
_             = require 'lodash'
moment        = require 'moment'
DetailPage    = require '../DetailPage.cjsx'
Helpers       = require '../Helpers.coffee'
{PrismCode}   = require 'react-prism'
ansi_up       = require('ansi_up')

{ Header, Split, Sidebar, Notification, Section, List, ListItem, Heading, Menu, Button, Icon } = require 'grommet'

InstanceControls = require '../menus/InstanceControls.cjsx'
Loading          = require '../Loading.cjsx'

li = (name, val) ->
  <ListItem justify='between'>
    <span>{name}</span>
    <span className='secondary'>{val}</span>
  </ListItem>

module.exports = React.createClass
  displayName: 'InstanceDetailPage'

  render: ->
    <Loading isLoading={@props.isLoading} render={@renderWithData} />

  renderWithData: ->
    instanceHelper = Helpers.withInstance @props.instance
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Notification pad='medium' status={instanceHelper.getStateValue()}
        message={instanceHelper.getStatusText()} />

        <Section pad='medium'>
          <List>
            {li 'Application', "#{@props.instance.app.name}:#{@props.instance.app.version}"}
            {li 'Storage bucket', @props.instance.storageBucket}
            {li 'Started by', @props.instance.startedBy}
          </List>
        </Section>

        <Section pad='medium'>
          <pre>
          <PrismCode className="language-bash">
            {@props.instance.logs?.startup?.join('')}
          </PrismCode>
          </pre>
        </Section>

        {_.map @props.instance.services, (service, name) ->
          <Section key={name} pad='medium'>
            <Heading tag='h2'>{name}</Heading>
            <List>
              {li 'Created', moment(service.container?.created).fromNow()}
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
        <InstanceControls instanceName={@props.instance.name} onStopInstance={@props.onStopInstance}/>
      </Sidebar>
    </Split>
