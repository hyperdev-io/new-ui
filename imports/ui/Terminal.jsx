import React from 'react';

export const Terminal = class Terminal extends React.Component {
  render() {
    var lines = this.props.children.map((line, key) => {
      if(line.type === 'kbd') {
        return (
          <div key={key} className="terminal-line">
            <span className="prompt">&gt; </span>
            <kbd>{line.props.children}</kbd>
          </div>
        );
      }
      else if (line.type === 'pre') {
        return (
          <div key={key} className="terminal-line">
            <pre>{line.props.children}</pre>
          </div>
        );
      }
    });

    return (
      <div className="terminal">
        <header>
          <div className="terminal-button button-close"></div>
          <div className="terminal-button button-minimize"></div>
          <div className="terminal-button button-zoom"></div>
        </header>

        <div className="terminal-output">
          {lines}
        </div>
      </div>
    );
  }
};
