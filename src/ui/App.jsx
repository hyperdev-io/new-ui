import { goToAboutPage, goToPortalPage, goToTokenPage } from '../redux/actions/navigation';

const React = require("react");
const { connect } = require("react-redux");

const G = require("grommet");
const { Button, Icons, Box, Menu, Anchor, Label } = G;
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
                a11yTitle="Logout"
                title="Logout"
                onClick={this.props.onLogout}
                icon={<Icons.Base.Logout />}
              />
              <Button
                align="start"
                plain={true}
                a11yTitle="About page"
                title="About page"
                onClick={this.props.goToAboutPage}
                icon={<Icons.Base.CircleInformation />}
              />
              <Box basis="full">
                {this.props.user &&
                  <Menu responsive={true}
                        dropAlign={{right:'right', bottom:'bottom'}}
                        alignSelf="end"
                        label={`${this.props.user.name.split(' ').map(n => n.substr(0, 1)).join('')}`}
                        inline={false}
                        icon={<img src={this.props.user.picture}
                                 alt={this.props.user.name}
                                 title={this.props.user.name}
                                 style={{borderRadius: '50%', width: 50}} />}
                        primary={false}
                        closeOnClick={true}>
                    <Anchor path='/portal'>
                      Manage HyperDev
                    </Anchor>
                    <Anchor path='/token'>
                      Auth tokens
                    </Anchor>
                  </Menu>
                }
              </Box>
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
  user: state.collections.user
});

const mapDispatchToProps = dispatch => ({
  onLogout: () => dispatch(logout()),
  goToAboutPage: () => dispatch(goToAboutPage()),
  goToPortalPage: () => dispatch(goToPortalPage()),
  goToTokenPage: () => dispatch(goToTokenPage()),
});

export default connect(mapStateToProps, mapDispatchToProps)(App);
