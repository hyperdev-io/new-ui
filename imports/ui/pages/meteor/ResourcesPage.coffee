_ = require 'lodash'
pretty            = require 'prettysize'
{ connect }       = require 'react-redux'

mapStateToProps = (state, {params}) ->
  ds = state.collections.dataStore
  buckets: buckets = state.collections.buckets
  dataStore:
    total: dsTotal = parseInt (ds?.total or 0)
    used: dsUsed = parseInt (ds?.used or 0)
    free: dsTotal - dsUsed
  isLoading: not buckets?
  selectedBucket: params.name

module.exports = connect(mapStateToProps) require '../ResourcesPage.cjsx'
