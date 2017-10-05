React                 = require 'react'
{withState, compose}  = require 'recompose'
{ Button, Layer, Box, Form, Header, Heading, Paragraph, FormFields, FormField, Footer, TextInput } = require 'grommet'
{ Terminal }     = require '../Terminal.jsx'


module.exports = ({hidden, log, instanceName, serviceName, onClose}) ->

  <Layer flush={true} onClose={onClose} align='right' closer={true} hidden={hidden}>
    <Box pad='none' full={true} style={backgroundColor: 'black'}>
      <Terminal outputStyle={height:'calc(100vh - 40px)'} title="Logs of #{instanceName}:#{serviceName}">
        {log?.map (line) ->
        #  console.log 'logline', line
         <pre>{line.message}</pre>
        }
      </Terminal>
    </Box>
  </Layer>
