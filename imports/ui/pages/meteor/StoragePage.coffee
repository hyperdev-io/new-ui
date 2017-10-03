_ = require 'lodash'
pretty            = require 'prettysize'
{ connect }       = require 'react-redux'

{ bucketSearchChanged }  = require '/imports/redux/actions/search.coffee'
{ openBucketPageRequest, copyBucketRequest } = require '/imports/redux/actions/buckets.coffee'

mapStateToProps = (state, {params}) ->
  ds = state.collections.dataStore
  searchVal = state.search?.bucket_search or ''

  dataStore:
    total: dsTotal = parseInt (ds?.total or 0)
    used: dsUsed = parseInt (ds?.used or 0)
    free: dsTotal - dsUsed
  selectedBucket: params.name
  isCopy: params.type is 'copy'
  searchValue: searchVal
  totalResults: state.collections.buckets?.length or 0
  buckets: _.filter state.collections.buckets, (bucket) -> bucket.name?.match(searchVal)

mapDispatchToProps = (dispatch) ->
  onBucketSearchChanged: (value) -> dispatch bucketSearchChanged value
  onClearSearch: -> dispatch bucketSearchChanged ''
  onActionMenuClose: (bucketName) -> dispatch openBucketPageRequest bucketName
  onCopy: (fromBucket, toBucket) ->
    dispatch copyBucketRequest fromBucket, toBucket
    dispatch openBucketPageRequest toBucket

module.exports = connect(mapStateToProps,mapDispatchToProps) require '../StoragePage.cjsx'
