const React               = require('react');
const { Link }            = require('react-router');
const Notifications       = require('./Notifications');
const { connect }         = require('react-redux');


const G = require('grommet')
const { Button, Icons } = G
const createReactClass = require("create-react-class")

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
                <img src="/logo-140.png" />
              </G.Header>
            </G.Box>
            <G.Menu fill={true} primary={true} direction="column">
              <G.Anchor path="/apps">Apps</G.Anchor>
              <G.Anchor path="/instances">Instances</G.Anchor>
              <G.Anchor path="/storage">Storage</G.Anchor>
              <G.Anchor path="/resources">Resources</G.Anchor>
              <G.Anchor path="/appstore">App Store</G.Anchor>
            </G.Menu>
            <G.Footer
              pad={{ horizontal: "medium", vertical: "small" }}
              align="center"
              direction="row"
            >
              {this.props.isLoggedIn ? (
                <Button
                  align="start"
                  plain={true}
                  onClick={this.props.onLogout}
                  icon={<Icons.Base.Logout />}
                />
              ) : (
                <Button
                  align="start"
                  plain={true}
                  path="/login"
                  icon={<Icons.Base.Login />}
                />
              )}
              <Button
                align="start"
                plain={true}
                icon={<Icons.Base.Configure />}
              />
              <Button
                align="start"
                plain={true}
                icon={<Icons.Base.Document />}
              />
            </G.Footer>
          </G.Sidebar>
          {this.props.children}
        </G.Split>
        {this.props.errorMessage && (
          <G.Toast status="critical" onClose={this.props.onErrorToastClose}>
            {this.props.errorMessage}
          </G.Toast>
        )}
        {this.props.infoMessage && (
          <G.Toast status="ok" onClose={this.onInfoToastClose}>
            {this.props.infoMessage}
          </G.Toast>
        )}
        <Notifications />
      </G.App>
    );
  }
});

const { userErrorAcknowledged } = require('../redux/actions/errors');
const { logout } = require('../redux/actions/user');

const mapStateToProps = state =>
  ({
    errorMessage: (state.error != null ? state.error.message : undefined),
    infoMessage: null,
    isLoggedIn: (state.collections.user != null)
  })
  ;

const mapDispatchToProps = dispatch =>
  ({
    onErrorToastClose() { return dispatch(userErrorAcknowledged()); },
    onLogout() { return dispatch(logout()); }
  })
  ;

module.exports = connect(mapStateToProps, mapDispatchToProps)(App);

