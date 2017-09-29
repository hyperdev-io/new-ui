_ = require 'lodash'
{ connect }           = require 'react-redux'
{ appSelected }       = require '/imports/redux/actions/apps.coffee'
{ appSearchChanged }  = require '/imports/redux/actions/search.coffee'
{ goToNewAppPage }    = require '/imports/redux/actions/navigation.coffee'

mapStateToProps = (state) ->
  searchVal = state.search?.app_search or ''
  appSearchValue: searchVal
  totalResults: state.collections.apps?.length or 0
  items: _.filter state.collections.apps, (app) -> app.name?.match(searchVal) or app.version?.match(searchVal)

mapDispatchToProps = (dispatch) ->
  onAppNameSelected: (app) -> dispatch appSelected app.name, app.version
  onAppSearchEntered: (value) -> dispatch appSearchChanged value
  onNewAppClicked: -> dispatch goToNewAppPage()
  onClearSearch: -> dispatch appSearchChanged ''

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../AppsPage.cjsx'
