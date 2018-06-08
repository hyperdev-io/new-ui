const React = require("react");
const { LoginForm, Box, Headline } = require("grommet");
const createReactClass = require("create-react-class");

const welcomeHeader = userName => <Headline>Welcome, {userName}</Headline>;
const loginForm = onSubmit => (
  <LoginForm
    onSubmit={onSubmit}
    primary={true}
    logo={<img src="/hyperdev-logo.png" className="loginLogo" alt="HyperDev Logo" />}
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
      <Box align="center" pad="large" alignContent="center">
        {this.props && this.props.isLoggedIn
          ? welcomeHeader(this.props.userFirstname)
          : loginForm(this.onSubmit)}
      </Box>
    );
  }
});
