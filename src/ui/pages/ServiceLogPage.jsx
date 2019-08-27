const React = require("react");
const DetailPage = require("../DetailPage");
const { Box, Button, Paragraph } = require("grommet");
const createReactClass = require("create-react-class");
const Anser = require("anser");

module.exports = createReactClass({
  displayName: "ServiceLogPage",

  getInitialState() {
    return {log: [], doScrolling: true};
  },

  componentDidMount: function() {
    console.log(this.props.params);
    var source;
    const location = window.location;
    var uri = `${location.protocol}//${location.host}/api/event-stream?serviceName=swarm-${this.props.params.name}_${this.props.params.service}`;
    source = new EventSource(uri);
    this.setState({source: source});
    source.addEventListener("ping", function(e) {
      //keep connection
    }, false);
    source.addEventListener('message', (e) => {
      var messageData = e.data;
      var {log}=this.state;
      messageData = messageData.split('\\n');
      log = log.concat(messageData);
      this.setState({log: log})
      setTimeout(() => this.setState({doScrolling: false}), 1000);
    });
  },

  componentWillUnmount: function() {
    const { source } = this.state
    source.close();
  },

  render: function() {
    if (this.props.notFound) {
      return (
        <Box
          align="center"
          textAlign="center"
          alignContent="center"
          direction="column"
          full={true}
          justify="center"
        >
          <Box width={150}>
            <h1>Instance not found...</h1>
            <Paragraph size="large">
              This instance doesn&#39;t exist anymore, probably it was just
              terminated.
            </Paragraph>
            <Box align="center" colorIndex="light-3" pad="medium">
              <Button
                label="Take me to the instances"
                primary={true}
                path="/instances"
              />
            </Box>
          </Box>
        </Box>
      );
    } else return this.renderWithData();
  },
  renderWithData: function() {
    var {doScrolling} = this.state;
    function createMarkup(line) {
      return {__html: Anser.ansiToHtml(JSON.parse('"' + line + '"'))};
    }
    return (
      <DetailPage title={this.props.title}>
        <Box full="vertical" pad="medium" style={{ backgroundColor: "black", color: "lightgrey", }} className="terminal-font">
          {this.state.log &&
          this.state.log.map((line, i) => {
            if (this.state.log.length-1===i && this.state.log.length<1000 && this.state.log.length>100 && doScrolling){
              document.querySelector(".grommetux-split__column--flex").scrollTop = document.querySelector(".grommetux-split__column--flex").scrollHeight
            }
            return <div key={i} dangerouslySetInnerHTML={createMarkup(line)} />
          })}
        </Box>
      </DetailPage>
    );
  }
});
