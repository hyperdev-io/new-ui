_ = require 'lodash'
{ connect }           = require 'react-redux'
{ appstoreSearchChanged }  = require '/imports/redux/actions/search.coffee'

mapStateToProps = (state) ->
  apps = state.collections.appstore_apps or []
  searchVal = state.search?.appstore_search or ''
  searchValue: searchVal
  totalResults: (_.values _.groupBy apps, (i) -> i.name).length
  apps: _.filter apps, (app) -> app.name?.match(searchVal)

mapDispatchToProps = (dispatch) ->
  onAppStoreSearchChanged: (value) -> dispatch appstoreSearchChanged value
  onClearSearch: -> dispatch appstoreSearchChanged ''

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../AppStorePage'
