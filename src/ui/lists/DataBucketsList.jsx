const React               = require('react');
const _                   = require('lodash');
const filesize            = require('filesize');
const moment              = require('moment');
const {Box, List, ListItem } = require('grommet');
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: 'DataBucketsList',

  listItemSelected(idx) {
    return console.log('data bucket selected', this.props.buckets[idx]);
  },

  render() {
     //Created {moment(bucket.created).fromNow()}
    return (
      <List selectable={true} onSelect={this.listItemSelected} 
        selected={ _.findIndex(this.props.buckets, (b) => b.name == this.props.selectedBucket)}>
        {this.props.buckets.map(bucket =>
          <ListItem key={bucket._id} pad='medium' justify='between' align='center'>
            <Box direction='column' pad='none'>
              <span style={{fontSize: 20}}>{bucket.name}</span>
            </Box>
            <Box direction='row' pad='none'>
              <span>{filesize(bucket.size || 0)}</span>
            </Box>
          </ListItem >
        )}
      </List >
    )
  }
});
