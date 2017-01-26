React         = require 'react'
DetailPage    = require '../DetailPage.cjsx'

{ Menu, Button, Icons, Layer, Form, Header, Heading, FormFields, Paragraph, Footer, Button } = require 'grommet'


module.exports = React.createClass
  displayName: 'InstanceControls'

  getInitialState: ->
    showStopInstanceDialog: false

  onClick: (eventType) -> =>
    @props.emit eventType, @props.instanceName

  stopInstance: ->
    @setState showStopInstanceDialog: false
    @props.emit 'stop instance', @props.instanceName

  showCloseLayer:  ->
    @setState showStopInstanceDialog: true

  hideCloseLayer: ->
    @setState showStopInstanceDialog: false

  render: ->
    <span>
      <Menu pad='medium'>
        <Button onClick={@showCloseLayer} align='start' plain=true label='Stop' icon={<Icons.Base.Power />}></Button>
        <Button onClick={@onClick 'show instance logs'} align='start' plain=true label='Logs' icon={<Icons.Base.Notes />}></Button>
        <Button onClick={@onClick 'delete instance'} align='start' plain=true label='Remove' icon={<Icons.Base.Trash />}></Button>
      </Menu>
      <Layer onClose={@hideCloseLayer} align='right' closer={true} hidden={not @state.showStopInstanceDialog}>
       <Form compact=true>
        <Header pad={vertical: 'medium'}><Heading>Stop</Heading></Header>
        <FormFields>
          <Paragraph>Are you sure you want to stop <strong>{@props.instanceName}</strong>?</Paragraph>
        </FormFields>
        <Footer pad={vertical:'medium'} justify='between' align='center'>
          <Button onClick={@stopInstance} secondary=true label='Yes, stop it' />
        </Footer>
       </Form>
      </Layer>
    </span>
