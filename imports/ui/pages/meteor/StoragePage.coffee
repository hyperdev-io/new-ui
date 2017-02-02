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
  ds = DataStores.findOne()

  buckets: StorageBuckets.find(searchObj, sort: name: 1).fetch()
  dataStore:
    total: dsTotal = parseInt (ds?.total or 0)
    used: dsUsed = parseInt (ds?.used or 0)
    free: dsTotal - dsUsed
, require '../StoragePage.cjsx'
