React         = require 'react'
DetailPage    = require '../DetailPage.cjsx'

{ Header, Box, Split, Sidebar, Tabs, Tab } = require 'grommet'
AppControls = require '../menus/AppControls.cjsx'
YamlEditor  = require '../editors/YamlEditor.cjsx'

module.exports = React.createClass
  displayName: 'AppsDetailPage'

  render: ->
    if @props.app
      @renderWithData()
    else @renderNoData()

  renderNoData: -> <span />

  onChange: (code) -> console.log 'onChange', code

  renderWithData: ->
    console.log @props.app
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Tabs style={marginBottom:0} responsive={false}>
          <Tab title='Docker Compose'>
            <YamlEditor code={@props.app.dockerCompose} />
          </Tab>
          <Tab title='BigBoat Compose'>
            <YamlEditor code={@props.app.bigboatCompose} />
          </Tab>
        </Tabs>
      </DetailPage>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' />
        <AppControls onRemoveApp={@props.onRemoveApp} onStartApp={@props.onStartApp} name={@props.title} />
      </Sidebar>
    </Split>
