const React         = require('react');
const { Menu, Button, Icons, Layer, Form, Header, Heading, FormFields, Paragraph, Footer } = require('grommet');
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: 'InstanceControls',

  getInitialState() {
    return {showStopInstanceDialog: false};
  },

  stopInstance() {
    this.setState({showStopInstanceDialog: false});
    return this.props.onStopInstance();
  },

  showCloseLayer() {
    return this.setState({showStopInstanceDialog: true});
  },

  hideCloseLayer() {
    return this.setState({showStopInstanceDialog: false});
  },

  render() { 
    return <span>
      <Menu pad='medium'>
        <Button onClick={this.showCloseLayer} align='start' plain={true} label='Stop' icon={<Icons.Base.Power />}></Button>
      </Menu>
      <Layer onClose={this.hideCloseLayer} align='right' closer={true} hidden={!this.state.showStopInstanceDialog}>
       <Form compact={true}>
        <Header pad={{vertical: 'medium'}}><Heading>Stop</Heading></Header>
        <FormFields>
          <Paragraph>Are you sure you want to stop <strong>{this.props.instanceName}</strong>?</Paragraph>
        </FormFields>
        <Footer pad={{vertical:'medium'}} justify='between' align='center'>
          <Button onClick={this.stopInstance} secondary={true} label='Yes, stop it' />
        </Footer>
       </Form>
      </Layer>
    </span>
  
  }
});
