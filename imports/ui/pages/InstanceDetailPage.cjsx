React         = require 'react'
_             = require 'lodash'
moment        = require 'moment'
DetailPage    = require '../DetailPage.cjsx'
Helpers       = require '../Helpers.coffee'
{PrismCode}   = require 'react-prism'
ansi_up       = require('ansi_up')

{ Anchor, Box, Header, Split, Sidebar, Notification, Section, List, ListItem, Heading, Menu, Button, Icons, Paragraph, Layer } = require 'grommet'

InstanceControls = require '../menus/InstanceControls.cjsx'
Loading          = require '../Loading.cjsx'
{ Terminal }     = require '../Terminal.jsx'
LogsLayer        = require '../layers/LogsLayer.cjsx'

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

  copyToClipboard: (data) -> ->
    element = document.createElement('textarea');
    element.value = data;
    document.body.appendChild(element);
    element.focus();
    element.setSelectionRange(0, element.value.length);
    document.execCommand('copy');
    document.body.removeChild(element);

  render: ->
    if @props.notFound
      <Box align='center' textAlign='center' alignContent='center' direction='column' full={true} justify='center'>
        <Box width=150>
          <h1>Instance not found...</h1>
          <Paragraph size='large'>Probably this instance was just terminated. Anyhow, it doesn&#39;t exist anymore.</Paragraph>
          <Box align='center' colorIndex='light-3' pad='medium'>
            <Button
              label='Take me to the instances'
              primary={true}
              path='/instances' />
          </Box>
        </Box>
      </Box>
    else @renderWithData()

  renderWithData: ->
    avatarAndName = =>
      <span>
        <img style={avatarStyle} src={@props.startedBy.gravatar} />
        {@props.startedBy.fullname}
      </span>

    iconLink = (content, onClickHandler, icon=Icons.Base.Link) ->
      <Anchor onClick={onClickHandler} icon={<icon style={width:20} />} label={<span style={fontSize:16, fontWeight:'normal'}>{content}</span>}/>

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

    renderSsh = (ssh) =>
      iconLink "ssh #{ssh.fqdn}", (@copyToClipboard "ssh #{ssh.fqdn}"), Icons.Base.Copy

    renderLogsButton = (service, name) =>
      <Button label='Logs' path="/instances/#{@props.instance.name}/#{name}/logs" />

    instanceHelper = Helpers.withInstance @props.instance

    if @props.instanceLink
      titleComponent = <Anchor reverse={true} href={@props.instanceLink} target='_blank'
        icon={<Icons.Base.Link style={width:60, marginBottom:20} />}
        label={<Heading tag='h1' style={display:'inline-block'} strong={true}>{@props.title}</Heading>} />

    <Split flex='left' priority='left'>
      <DetailPage title={titleComponent or @props.title} >
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
          <Terminal outputStyle={minHeight: 100, maxHeight: 250}>
            <kbd>docker-compose up</kbd>
            <pre>
              {@props.instance.logs?.startup?.join('')}
            </pre>
            {if @props.instance?.state is 'running'
              <pre>
                done. instance running
              </pre>
            }
            {<kbd>docker-compose down</kbd> if @props.instance.logs?.teardown?}
            <pre>
              {@props.instance.logs?.teardown?.join('')}
            </pre>
          </Terminal>
        </div>

        {unless @props.instance?.services
          <Box alignContent='center' pad='large' align='center'>
            <h3>Service information will be displayed here as soon as the instance starts...</h3>
          </Box>
        }

        {_.map @props.instance.services, (service, name) =>
          <Section key={name} pad='medium'>
            <Anchor reverse={true} href={@props.serviceLinks[name]} target='_blank'
              icon={<Icons.Base.Link style={width:20} />}
              label={<span style={fontSize:26, fontWeight:'normal'}>{name}</span>} />
            <List>
              {li 'Created', moment(service.container?.created).fromNow()}
              {li 'State', renderStatus service}
              {li 'FQDN', service.fqdn}
              {li 'Container name', service.container?.name}
              {li 'Ports', service.ports}
              {li 'Network', renderNetwork service.aux?.net}
              {if service.aux?.ssh
                li 'SSH', renderSsh service.aux.ssh
              }
              {li 'Logs', renderLogsButton service, name}
            </List>
          </Section>
        }
        <LogsLayer
          hidden={not @props.showLogs}
          onClose={@props.onLogClose}
          instanceName={@props.instance.name}
          serviceName={@props.service}
          log={@props.log}
        />
      </DetailPage>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' />
        <InstanceControls instanceName={@props.instance.name} onStopInstance={@props.onStopInstance}/>
      </Sidebar>
    </Split>
