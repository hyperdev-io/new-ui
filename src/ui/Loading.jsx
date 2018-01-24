const React = require("react");
const { Box, Icons } = require("grommet");
const Spinner = require("react-spinkit");
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: "Loading",
  renderSpinner(){
    return <Box align='center' flex={true} full={true} justify='center'>
        <Spinner spinnerName='rotating-plane' />
      </Box>
  },
  render() {
    return this.props.isLoading ? this.renderSpinner() : this.props.render()
  }
});
