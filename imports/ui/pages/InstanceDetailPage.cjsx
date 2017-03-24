React         = require 'react'
_             = require 'lodash'
moment        = require 'moment'
DetailPage    = require '../DetailPage.cjsx'
Helpers       = require '../Helpers.coffee'
{PrismCode}   = require 'react-prism'
ansi_up       = require('ansi_up')

{ Anchor, Box, Header, Split, Sidebar, Notification, Section, List, ListItem, Heading, Menu, Button, Icons } = require 'grommet'

InstanceControls = require '../menus/InstanceControls.cjsx'
Loading          = require '../Loading.cjsx'
{ Terminal }     = require '../Terminal.jsx'

avatarStyle =
  width: 20
  height: 20
  borderRadius: 150
  WebkitBorderRadius: 150
  MozkitBorderRadius: 150
  marginRight: 10

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
    avatarAndName = =>
      <span>
        <img style={avatarStyle} src={@props.startedBy.gravatar} />
        {@props.startedBy.fullname}
      </span>

    iconLink = (content, onClickHandler) =>
      <Anchor onClick={onClickHandler} icon={<Icons.Base.Link style={width:20} />} label={<span style={fontSize:16, fontWeight:'normal'}>{content}</span>}/>

    appWithLink = =>
      iconLink "#{@props.instance.app.name}:#{@props.instance.app.version}", @props.onOpenAppPage

    renderStatus = (s) ->
      status = if (stat = s.health?.status) is 'unknown' then 'waiting for container to become healthy' else stat
      <span>
        {s.state} {if status then "(#{status})"}
      </span>

    renderNetwork = (net) ->
      if net
        ip = if net.ip? then ", ip: #{net.ip}" else ''
        status = if (stat = net.health?.status) is 'unknown' then 'waiting for container to become healthy' else stat
        <span>
          {net.state} ({status}{ip})
        </span>

    instanceHelper = Helpers.withInstance @props.instance
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Notification pad='medium' status={instanceHelper.getStateValue()}
        message={instanceHelper.getStatusText()} />

        <Section pad='medium'>
          <List>
            {li 'Application', appWithLink()}
            {if bucket = @props.instance.storageBucket
              li 'Storage bucket', iconLink bucket, @props.onOpenBucketPage
            }
            {li 'Started by', avatarAndName()}
          </List>
        </Section>

        <div className='terminal-wrapper'>
          <Terminal>
            <kbd>docker-compose up</kbd>
            <pre>
              {@props.instance.logs?.startup?.join('')}
            </pre>
          </Terminal>
        </div>

        {unless @props.instance?.services
          <Box alignContent='center' pad='large' align='center'>
            <h3>Service information will be displayed here as soon as the instance starts...</h3>
          </Box>
        }

        {_.map @props.instance.services, (service, name) ->
          <Section key={name} pad='medium'>
            <Heading tag='h2'>{name}</Heading>
            <List>
              {li 'Created', moment(service.container?.created).fromNow()}
              {li 'State', renderStatus service}
              {li 'FQDN', service.fqdn}
              {li 'Container name', service.container?.name}
              {li 'Ports', service.ports}
              {li 'Network', renderNetwork service.aux?.net}
              {if service.aux.ssh
                console.log 'ssh', service.aux.ssh
                li 'SSH', renderStatus service.aux.ssh
              }
            </List>
          </Section>
        }
      </DetailPage>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' />
        <InstanceControls instanceName={@props.instance.name} onStopInstance={@props.onStopInstance}/>
      </Sidebar>
    </Split>
