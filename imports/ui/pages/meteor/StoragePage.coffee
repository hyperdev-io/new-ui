_ = require 'lodash'
{ createContainer } = require 'meteor/react-meteor-data'


module.exports = createContainer (props) ->
  App = props.route.App
  StorageBuckets = App.collections.StorageBuckets

  App.subscribe.allStorageBuckets()

  # selectedAppName = App.state.selectedAppName()
  # appSearchValue = App.state.appSearchValue()

  searchObj = {}
  # if appSearchValue then searchObj = name: {$regex: appSearchValue, $options: 'i'}
  # selectedBucket: selectedBucket
  # bucketSearchValue: bucketSearchValue
  # appNameSelected: (name) -> App.emit 'app name selected', name
  # appsSearchEntered: (value) -> App.emit 'app search entered', value

  console.table StorageBuckets.find(searchObj, sort: name: 1).fetch()
  buckets: StorageBuckets.find(searchObj, sort: name: 1).fetch()
, require '../StoragePage.cjsx'
