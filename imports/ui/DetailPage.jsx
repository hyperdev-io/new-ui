const React = require("react");
const G = require("grommet");

const { Router, browserHistory } = require("react-router");

module.exports = React.createClass({
  displayName: "DetailPage",

  goBack() {
    return browserHistory.goBack();
  },

  render() {
    let titleComponent = this.props.title;
    if (this.props.title && this.props.title.length) {
      titleComponent = <G.Heading strong={true}>{this.props.title}</G.Heading>;
    }

    return (
      <G.Article>
        <G.Header fixed={true} pad={{ vertical: "small", between: "small" }}>
          <G.Box pad="small">
            <G.Anchor
              icon={<G.Icons.Base.LinkPrevious />}
              onClick={this.goBack}
            />
          </G.Box>
          <G.Title responsive={true} flex="grow">
            {titleComponent}
          </G.Title>
        </G.Header>

        {this.props.children}
      </G.Article>
    );
  }
});
