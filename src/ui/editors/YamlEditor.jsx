const React         = require('react');
const jsyaml        = require('js-yaml');

const { Box } = require('grommet');
const AceEditor = (require('react-ace')).default;
const createReactClass = require("create-react-class");
require('brace/mode/yaml');
require('brace/theme/github');

module.exports = createReactClass({
  displayName: 'YamlEditor',

  shouldComponentUpdate(nextProps, nextState) {
    return this.props.code !== nextProps.code;
  },

  onChange(code) {
    const { session } = this.refs.ace.editor;
    try {
      const yamlobj = jsyaml.load(code);
      this.props.onChange(yamlobj, code);
      return session.setAnnotations([]);
    } catch (error) {
      const line = error.mark.line === session.doc.getAllLines().length ? error.mark.line - 1 : error.mark.line;
      return session.setAnnotations([{
        row: line,
        column: error.mark.column,
        text: error.reason,
        type: 'error'
      }
      ]);
    }
  },

  render() {
    return (
      <Box>
      <AceEditor
        ref="ace"
        mode="yaml"
        theme="github"
        onChange={this.onChange}
        name="ace-#{@props.name}"
        height='calc(100vh - 147px)'
        width='100%'
        fontSize={16}
        value={this.props.code}
        setOptions={{fixedWidthGutter:'50px'}}
        editorProps={{$blockScrolling: true}}
        enableBasicAutocompletion={true}
      />
    </Box>
    )
  }
});
