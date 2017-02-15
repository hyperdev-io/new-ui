React = require 'react'
Page  = require '../Page.cjsx'
_     = require 'lodash'
{ Box, Heading, Header, Form, FormFields, FormField, TextInput, Select }     = require 'grommet'

module.exports  = React.createClass
  displayName: 'NewInstancePage'

  getAppNameFromProps: ->
    if name = @props.selectedAppName and version = @props.selectedAppVersion
      "#{name} (#{version})"

  getInitialState: ->
    app: @getAppNameFromProps() or ''
    name: ''

  onAppSelectChange: (evt) ->
    console.log evt
    @setState app: evt.value

  onAppSelectSearch: (evt) ->
    searchValue = evt.target.value
    @setState appOptions: _.filter @props.apps, (app) -> (app.name.match(searchValue) or app.version.match(searchValue))

  onNameChange: (evt,a,v) ->
    @setState name: evt.target.value

  appToOptionValue: (app) ->
    value: "#{app.name} (#{app.version})"
    id: app._id
    label: <Box direction='row' justify='between'><span>{app.name}</span><span className='secondary'>{app.version}</span></Box>

  render: ->
    console.log @props.apps
    <Box align='center' pad='medium'>
      <Form compact=false fill=false>
        <Header>
          <Box align='center' pad='large' alignContent='center'>
            <Heading tag='h2' strong=true>New Instance</Heading>
          </Box>
        </Header>
        <FormFields>
          <FormField label='Application definition' htmlFor='app' size='medium'>
            <Select placeHolder='Search'
              inline={false}
              multiple={false}
              onSearch={@onAppSelectSearch}
              options={(@state.appOptions or @props.apps).map @appToOptionValue}
              value={@state.app}
              onChange={@onAppSelectChange} />
          </FormField>
          <FormField label='Instance name' htmlFor='name' size='medium'>
            <TextInput ref='name' placeHolder='A unique name to identify this instance' value={@state.name} onDOMChange={@onNameChange} />
          </FormField>
        </FormFields>
      </Form>
    </Box>
