const React      = require('react')
const DetailPage = require("../DetailPage");

const { Header, Box, Split, Sidebar, Tabs, Tab } = require('grommet')
const createReactClass = require("create-react-class");
const AppControls = require("../menus/AppControls");
const YamlEditor = require("../editors/YamlEditor");
const Loading = require("../Loading");

module.exports = createReactClass({
  displayName: 'AppsDetailPage',

  getInitialState: function(){
    return {
      dockerCompose: this.props.dockerCompose,
      bigboatCompose: this.props.bigboatCompose
    }
  },

  render: function (){return <Loading isLoading={this.props.isLoading} render={this.renderWithData} />},

  onComposeChange: function(yamlobj, code){return this.setState({dockerCompose: code})},
  onBigboatChange: function(yamlobj, code) {
    console.log(yamlobj)
    this.setState({bigboatCompose: code})
    this.setState({ name: yamlobj.name })
    this.setState({ version: yamlobj.version })
  },
  onSaveApp: function(){ this.props.onSaveApp(this.state.dockerCompose, this.state.bigboatCompose, this.state.name, this.state.version)},
  isSaveButtonDisabled: function() {
    const sdc = this.state.dockerCompose;
    const sbc = this.state.bigboatCompose;
    return (sdc === this.props.dockerCompose ||  !sdc) &&
    (sbc === this.props.bigboatCompose || !sbc)
  },

  renderWithData: function() {
    return (
      <Split flex='left' priority='left'>
        <DetailPage title={this.props.title} >
          <Tabs style={{marginBottom:0}} responsive={false}>
            <Tab title='Docker Compose'>
              <YamlEditor name='dockerCompose' code={this.state.dockerCompose || this.props.dockerCompose} onChange={this.onComposeChange} />
            </Tab>
            <Tab title='BigBoat Compose'>
              <YamlEditor name='bigboatCompose' code={this.state.bigboatCompose || this.props.bigboatCompose} onChange={this.onBigboatChange} />
            </Tab>
          </Tabs>
        </DetailPage>
        <Sidebar size='medium' colorIndex='light-2' direction='column'>
          <Header pad='medium' size='large' />
          <AppControls
            saveButtonDisabled={this.isSaveButtonDisabled()}
            removeButtonDisabled={this.props.isNewApp}
            startButtonDisabled={this.props.isNewApp}
            onSaveApp={this.onSaveApp}
            onRemoveApp={this.props.onRemoveApp}
            onStartApp={this.props.onStartApp}
            name={this.props.title} />
        </Sidebar>
      </Split>
    )
  },
})