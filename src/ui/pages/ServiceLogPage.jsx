const React = require("react");
const DetailPage = require("../DetailPage");
const { Box, Button, Paragraph } = require("grommet");
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: "ServiceLogPage",

  getInitialState() {
    return {log: []};
  },

  componentDidMount: function() {
    var source;
    const location = window.location;
    var uri = `${location.protocol}//${location.host}/api/event-stream?serviceName=swarm-${this.props.params.name}_${this.props.params.service}`;
    source = new EventSource(uri);
    this.setState({source: source})
    source.addEventListener('message', (e) => {
      var messageData = e.data;
      var {log}=this.state;
      var match = messageData.includes('\\n');
      if (match) {
        messageData = messageData.split('\\n')
        log = log.concat(messageData);
      } else {
        log.push(messageData);
      }
      this.setState({log: log})
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
    return (
      <DetailPage title={this.props.title}>
        <Box full="vertical" pad="medium" style={{ backgroundColor: "black", color: "lightgrey", }} className="terminal-font">
          {this.state.log &&
            this.state.log.map((line, i) => (
              <span key={i} style={{ whiteSpace: "pre-line" }}>
                {line}
              </span>
            ))}
        </Box>
      </DetailPage>
    );
  }
});
