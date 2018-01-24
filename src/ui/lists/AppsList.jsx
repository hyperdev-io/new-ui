const React = require("react");
const { Box, List, ListItem } = require("grommet");
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: "AppsList",

  listItemSelected(idx) {
    return this.props.onAppNameSelected(this.props.apps[idx]);
  },

  render() {
    return <List selectable={true} onSelect={this.listItemSelected}>
      {this.props.apps.map(app => (
        <ListItem key={app._id} pad="medium" justify="between" align="center">
          <Box direction="column" pad="none">
            <strong>{app.name}</strong>
            <span>{app.version}</span>
          </Box>
        </ListItem>
      ))}
    </List>;
  }
});
