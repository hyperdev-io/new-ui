_ = require 'lodash'
{ createContainer } = require 'meteor/react-meteor-data'
pretty              = require 'prettysize'

module.exports = createContainer (props) ->
  App = props.route.App
  StorageBuckets = App.collections.StorageBuckets
  DataStores = App.collections.DataStores

  App.subscribe.allStorageBuckets()
  App.subscribe.allDataStores()

  # selectedAppName = App.state.selectedAppName()
  # appSearchValue = App.state.appSearchValue()

  searchObj = {}
  # if appSearchValue then searchObj = name: {$regex: appSearchValue, $options: 'i'}
  # selectedBucket: selectedBucket
  # bucketSearchValue: bucketSearchValue
  # appNameSelected: (name) -> App.emit 'app name selected', name
  # appsSearchEntered: (value) -> App.emit 'app search entered', value
  console.table DataStores.find().fetch()
  console.table StorageBuckets.find(searchObj, sort: name: 1).fetch()
  buckets: StorageBuckets.find(searchObj, sort: name: 1).fetch().map (bucket) ->
    _.extend bucket,
      size: pretty bucket.size
, require '../StoragePage.cjsx'
