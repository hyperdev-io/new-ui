React         = require 'react'
jsyaml        = require 'js-yaml'

{ Box } = require 'grommet'
AceEditor = (require 'react-ace').default
require 'brace/mode/yaml'
require 'brace/theme/github'

module.exports = React.createClass
  displayName: 'YamlEditor'

  shouldComponentUpdate: (nextProps, nextState) ->
    @props.code isnt nextProps.code

  onChange: (code) ->
    session = @refs.ace.editor.session
    try
      yamlobj = jsyaml.load code
      @props.onChange yamlobj, code
      session.setAnnotations []
    catch error
      line = if error.mark.line == session.doc.getAllLines().length then error.mark.line - 1 else error.mark.line
      session.setAnnotations [
        row: line
        column: error.mark.column
        text: error.reason
        type: 'error'
      ]

  render: ->
    <Box>
      <AceEditor
        ref="ace"
        mode="yaml"
        theme="github"
        onChange={@onChange}
        name="compose-editor"
        height='calc(100vh - 147px)'
        width='100%'
        fontSize=16
        value={@props.code}
        setOptions={fixedWidthGutter:'50px'}
        editorProps={{$blockScrolling: true}}
        enableBasicAutocompletion=true
      />
    </Box>
