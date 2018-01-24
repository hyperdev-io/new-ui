const React         = require('react');
const { Box, Menu, Button, Icons, Layer, Form, Header, Heading, FormFields, Paragraph, Footer } = require('grommet');
const createReactClass = require("create-react-class");


module.exports = createReactClass({
  displayName: 'AppControls',

  getInitialState() {
    return {showRemoveAppOverlay: false};
  },

  removeApp() {
    this.setState({showRemoveAppOverlay: false});
    return this.props.onRemoveApp();
  },

  showRemoveLayer() {
    return this.setState({showRemoveAppOverlay: true});
  },

  hideRemoveLayer() {
    return this.setState({showRemoveAppOverlay: false});
  },

  render() {
    const saveButtonHandler = this.props.saveButtonDisabled ? null : this.props.onSaveApp;
    const removeButtonHandler = this.props.removeButtonDisabled ? null : this.showRemoveLayer;
    const startButtonHandler = this.props.startButtonDisabled ? null : this.props.onStartApp;
    return <span>
      <Menu pad='medium'>
        <Button onClick={saveButtonHandler} align='start' plain={true} label='Save' icon={<Icons.Base.Save />}></Button>
        <Button onClick={removeButtonHandler} align='start' plain={true} label='Remove' icon={<Icons.Base.Trash />}></Button>
        <Box pad='medium'></Box>
        <Button onClick={startButtonHandler} align='start' plain={true} label='Start' icon={<Icons.Base.Play />}></Button>
      </Menu>
      <Layer onClose={this.hideRemoveLayer} align='right' closer={true} hidden={!this.state.showRemoveAppOverlay}>
       <Form compact={true}>
        <Header pad={{vertical: 'medium'}}><Heading>Remove</Heading></Header>
        <FormFields>
          <Paragraph>Are you sure you want to remove <strong>{this.props.name}</strong>?</Paragraph>
          <Paragraph>This action is irreversable.</Paragraph>
        </FormFields>
        <Footer pad={{vertical:'medium'}} justify='between' align='center'>
          <Button onClick={this.removeApp} secondary={true} label='Yes, remove it' />
        </Footer>
       </Form>
      </Layer>
    </span>
  }
});
