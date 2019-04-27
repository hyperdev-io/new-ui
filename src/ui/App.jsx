const React = require("react");
const { connect } = require("react-redux");

const G = require("grommet");
const { Button, Icons } = G;
const createReactClass = require("create-react-class");

const App = createReactClass({
  displayName: "App",
  getInitialState: () => ({ priority: "right" }),
  switchSideBar: () =>
    this.setState({
      priority: this.state.priority === "right" ? "left" : "right"
    }),
  render: function() {
    return (
      <G.App centered={false}>
        <G.Split flex="right" priority={this.state.priority}>
          <G.Sidebar colorIndex="neutral-1">
            <G.Box align="center">
              <G.Header size="large" justify="between">
                <img src="/img/hyperdev-logo.png" alt="HyperDev Logo" style={{maxHeight: 150}} />
              </G.Header>
            </G.Box>
            <G.Menu fill={true} primary={true} direction="column">
              <G.Anchor path="/apps">Apps</G.Anchor>
              <G.Anchor path="/instances">Instances</G.Anchor>
              <G.Anchor path="/storage">Storage</G.Anchor>
              <G.Anchor path="/resources">Resources</G.Anchor>
              {/*<G.Anchor path="/appstore">App Store</G.Anchor>*/}
            </G.Menu>
            <G.Footer
              pad={{ horizontal: "medium", vertical: "small" }}
              align="center"
              direction="row"
            >
              <Button
                align="start"
                plain={true}
                onClick={this.props.onLogout}
                icon={<Icons.Base.Logout />}
              />
              <Button
                align="start"
                plain={true}
                icon={<Icons.Base.Configure />}
              />
              <Button
                align="start"
                plain={true}
                icon={<Icons.Base.CircleInformation />}
              />
            </G.Footer>
          </G.Sidebar>
          {this.props.children}
        </G.Split>
      </G.App>
    );
  }
});

const { logout } = require("../redux/actions/user");

const mapStateToProps = state => ({
  errorMessage: state.error != null ? state.error.message : undefined,
  infoMessage: null,
  isLoggedIn: state.collections.user != null
});

const mapDispatchToProps = dispatch => ({
  onLogout() {
    return dispatch(logout());
  }
});

export default connect(mapStateToProps, mapDispatchToProps)(App);
