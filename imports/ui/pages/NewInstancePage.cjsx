React = require 'react'
Page  = require '../Page.cjsx'
_     = require 'lodash'
{ Box, Button, Heading, Header, Footer, Form, FormFields, FormField, TextInput, Select, CheckBox, Anchor, Icons } = require 'grommet'

module.exports  = React.createClass
  displayName: 'NewInstancePage'

  getAppParams: ->
    params = @props.selectedApp.dockerCompose?.match /(?:\{\{)([\d|\w|_|-]*?)(?=\}\})/g
    if params?.length
      _.uniq(params.map (p) -> p.replace('{{', '').trim())
    else
      []

  getAppNameFromProps: ->
    if name = @props.selectedAppName and version = @props.selectedAppVersion
      "#{name} (#{version})"

  onAppSelectChange: (evt) ->
    @props.onAppSelected evt.value.name, evt.value.version

  onBucketSelected: (evt) ->
    @props.onStateChanged bucket: evt.option

  onAppSelectSearch: (evt) ->
    searchValue = evt.target.value
    @props.onStateChanged appsearch: evt.target.value

  onNameChange: (evt,a,v) ->
    @props.onStateChanged name: evt.target.value

  onParamChanged: (name) -> (evt) =>
    obj = {}; obj["param_#{name}"] = evt.target.value
    @props.onStateChanged obj

  appToOptionValue: (app) ->
    value: "#{app.name} (#{app.version})"
    id: app._id
    name: app.name
    version: app.version
    label: <Box direction='row' justify='between'><span>{app.name}</span><span className='secondary'>{app.version}</span></Box>

  getAppOptions: ->
    _.filter @props.apps, (app) => (app.name.match(@props.appsearch) or app.version.match(@props.appsearch))

  startInstance: (evt) ->
    @props.onStartInstance()

  render: ->
    <Box align='center' pad='medium'>
      <Form compact=false fill=false>
        <Header size='large' pad='none' justify='between'>
          <Heading tag='h2' margin='none' strong=true>New Instance</Heading>
          <Anchor icon={<Icons.Base.Close />} onClick={@props.onClose} />
        </Header>
        <FormFields>
          <fieldset>
            <FormField label='Application definition' htmlFor='app' size='medium'>
              <Select placeHolder='Search'
                inline={false}
                multiple={false}
                onSearch={@onAppSelectSearch}
                options={(@getAppOptions() or @props.apps).map @appToOptionValue}
                value={"#{@props.selectedAppName} (#{@props.selectedAppVersion})"}
                onChange={@onAppSelectChange} />
            </FormField>
            <FormField label='Instance name' htmlFor='name' size='medium' error="">
              <TextInput placeHolder='A unique name to identify this instance' value={@props.name} onDOMChange={@onNameChange} />
            </FormField>
          </fieldset>
          {if @props.selectedApp
            params = @getAppParams()
            <fieldset>
              {if params.length
                <Box direction='row' justify='between'>
                  <Heading tag='h3'>App parameters</Heading>
                </Box>
              }

              {params.map (param) =>
                <FormField key={param} label={param} htmlFor={param} size='medium'>
                  <TextInput value={@props.appParams?["param_#{param}"]} onDOMChange={@onParamChanged(param)} />
                </FormField>
              }
            </fieldset>
          }

          <fieldset>
            <Box direction='row' justify='between'>
              {
                heading = <Heading style={paddingTop:10} tag='h3'>Persisted Storage</Heading>
                <CheckBox label={heading} toggle={true} defaultChecked />
              }
            </Box>

            <FormField label='Storage bucket' size='medium' >
              <Select onSearch={-> console.log 'search'} value={@props.bucket or @props.name} onChange={@onBucketSelected} options={@props.buckets}/>
            </FormField>
          </fieldset>
        </FormFields>

        <Footer pad={vertical: 'medium'}>
          <Button type="button" primary=true label="Start Instance" onClick={@startInstance} />
        </Footer>
      </Form>
    </Box>
