const React = require("react");
const DetailPage = require("../DetailPage");
const Helpers = require("../Helpers");
const { PrismCode } = require("react-prism");
const ansi_up = require("ansi_up");

const { Box, Button, Paragraph } = require("grommet");

const Loading = require("../Loading");
const LogsLayer = require("../layers/LogsLayer");
const { Terminal } = require("../Terminal");
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: "ServiceLogPage",

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
        <Box pad="medium" style={{ backgroundColor: "black", color: "lightgrey" }}>
          {this.props.log &&
            this.props.log.map((line, i) => (
              <pre key={i} style={{ whiteSpace: "pre-line" }}>
                {line}
              </pre>
            ))}
        </Box>
      </DetailPage>
    );
  }
});
