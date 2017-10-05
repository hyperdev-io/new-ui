import React from 'react';

export const Terminal = class Terminal extends React.Component {
  componentDidUpdate() {
      const term = this.refs.terminal
      term.scrollTop = term.scrollHeight
  }
  render() {
    var lines = this.props.children.map((line, key) => {
      if(line && line.type === 'kbd') {
        return (
          <div key={key} className="terminal-line">
            <span className="prompt">&gt; </span>
            <kbd>{line.props.children}</kbd>
          </div>
        );
      }
      else if (line && line.type === 'pre') {
        return (
          <div key={key} className="terminal-line">
            <pre style={{margin:0, whiteSpace: 'pre-wrap'}}>{line.props.children}</pre>
          </div>
        );
      }
    });

    return (
      <div className="terminal" style={this.props.style}>
        <header>
          <div className="terminal-button button-close"></div>
          <div className="terminal-button button-minimize"></div>
          <div className="terminal-button button-zoom"></div>
          <div className="terminal-header">{this.props.title}</div>
        </header>

        <div ref='terminal' className="terminal-output" style={this.props.outputStyle}>
          {lines}
        </div>
      </div>
    );
  }
};
