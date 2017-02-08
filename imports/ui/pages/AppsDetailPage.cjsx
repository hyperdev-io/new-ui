React         = require 'react'
DetailPage    = require '../DetailPage.cjsx'

{ Header, Box, Split, Sidebar, Tabs, Tab } = require 'grommet'
AppControls = require '../menus/AppControls.cjsx'
YamlEditor  = require '../editors/YamlEditor.cjsx'

module.exports = React.createClass
  displayName: 'AppsDetailPage'

  getInitialState: ->
    dockerCompose: @props.dockerCompose
    bigboatCompose: @props.bigboatCompose

  render: ->
    if @props.dockerCompose
      @renderWithData()
    else @renderNoData()

  renderNoData: -> <span />

  onComposeChange: (yamlobj, code) -> @setState dockerCompose: code
  onBigboatChange: (yamlobj, code) -> @setState bigboatCompose: code
  onSaveApp: -> @props.onSaveApp @state.dockerCompose, @state.bigboatCompose
  isSaveButtonDisabled: ->
    sdc = @state.dockerCompose
    sbc = @state.bigboatCompose
    (sdc is @props.dockerCompose or not sdc?) and
    (sbc is @props.bigboatCompose or not sbc?)

  renderWithData: ->
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Tabs style={marginBottom:0} responsive={false}>
          <Tab title='Docker Compose'>
            <YamlEditor name='dockerCompose' code={@state.dockerCompose or @props.dockerCompose} onChange={@onComposeChange} />
          </Tab>
          <Tab title='BigBoat Compose'>
            <YamlEditor name='bigboatCompose' code={@state.bigboatCompose or @props.bigboatCompose} onChange={@onBigboatChange} />
          </Tab>
        </Tabs>
      </DetailPage>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' />
        <AppControls
          saveButtonDisabled={@isSaveButtonDisabled()}
          onSaveApp={@onSaveApp}
          onRemoveApp={@props.onRemoveApp}
          onStartApp={@props.onStartApp}
          name={@props.title} />
      </Sidebar>
    </Split>
