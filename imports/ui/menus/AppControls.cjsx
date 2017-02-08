React         = require 'react'

{ Box, Menu, Button, Icons, Layer, Form, Header, Heading, FormFields, Paragraph, Footer, Button } = require 'grommet'


module.exports = React.createClass
  displayName: 'AppControls'

  getInitialState: ->
    showRemoveAppOverlay: false

  removeApp: ->
    @setState showRemoveAppOverlay: false
    @props.onRemoveApp()

  showRemoveLayer:  ->
    @setState showRemoveAppOverlay: true

  hideRemoveLayer: ->
    @setState showRemoveAppOverlay: false

  render: ->
    saveButtonHandler = if @props.saveButtonDisabled then null else @props.onSaveApp
    <span>
      <Menu pad='medium'>
        <Button onClick={saveButtonHandler} align='start' plain=true label='Save' icon={<Icons.Base.Save />}></Button>
        <Button onClick={@showRemoveLayer} align='start' plain=true label='Remove' icon={<Icons.Base.Trash />}></Button>
        <Box pad='medium'></Box>
        <Button onClick={@props.onStartApp} align='start' plain=true label='Start' icon={<Icons.Base.Play />}></Button>
      </Menu>
      <Layer onClose={@hideRemoveLayer} align='right' closer={true} hidden={not @state.showRemoveAppOverlay}>
       <Form compact=true>
        <Header pad={vertical: 'medium'}><Heading>Remove</Heading></Header>
        <FormFields>
          <Paragraph>Are you sure you want to remove <strong>{@props.name}</strong>?</Paragraph>
        </FormFields>
        <Footer pad={vertical:'medium'} justify='between' align='center'>
          <Button onClick={@removeApp} secondary=true label='Yes, remove it' />
        </Footer>
       </Form>
      </Layer>
    </span>
