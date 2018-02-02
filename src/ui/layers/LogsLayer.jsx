const React                 = require('react');
const { Layer, Box } = require('grommet');
const { Terminal }     = require('../Terminal.jsx');


module.exports = ({hidden, log = [], instanceName, serviceName, onClose}) => 
  <Layer flush={true} onClose={onClose} align='right' closer={true} hidden={hidden}>
    <Box pad='none' full={true} style={{backgroundColor: 'black'}}>
      <Terminal outputStyle={{height:'calc(100vh - 40px)'}} title={`Showing the last 1000 lines of the ${instanceName}:${serviceName} logs`}>
        {log.map(line => <pre>{line}</pre>)}
      </Terminal>
    </Box>
  </Layer>
