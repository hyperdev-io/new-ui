const React = require('react');
const G     = require('grommet');
const createReactClass = require("create-react-class");

module.exports  = createReactClass({
  displayName: 'Page',

  render() {
    return <G.Article>
      <G.Header fixed={true} pad='medium'>
        <G.Title responsive={true} flex='grow'>{this.props.title || this.props.route.title}</G.Title>
      </G.Header>

      {this.props.children}

    </G.Article>
  }
});
