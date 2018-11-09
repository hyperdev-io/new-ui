const React = require("react");
const { App, LoginForm, Box, Headline } = require("grommet");
const createReactClass = require("create-react-class");

const loginForm = (onSubmit, authenticationFailed) => (
  <LoginForm
    onSubmit={onSubmit}
    primary={true}
    errors={authenticationFailed ? ['Invalid credentials.'] : []}
    logo={<img src="/img/hyperdev-logo.png" className="loginLogo" alt="HyperDev Logo" />}
    rememberMe={false}
    usernameType="text"
  />
);

module.exports = createReactClass({
  displayName: "LoginPage",
  onSubmit: function(credentials) {
    this.props.onLogin(credentials.username, credentials.password);
  },
  render: function() {
    return (
      <App centered={true}>
        <Box align="center" pad="large" alignContent="center">
          { loginForm(this.onSubmit, this.props.authenticationFailed) }
        </Box>
      </App>
    );
  }
});
