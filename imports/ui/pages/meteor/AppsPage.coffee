_ = require 'lodash'
{ connect }           = require 'react-redux'
{ appSelected }       = require '/imports/redux/actions/apps.coffee'
{ appSearchChanged }  = require '/imports/redux/actions/search.coffee'
{ goToNewAppPage }    = require '/imports/redux/actions/navigation.coffee'

mapStateToProps = (state) ->
  searchVal = state.search?.app_search or ''
  apps: _.filter state.collections.apps, (app) -> app.name?.match(searchVal) or app.version?.match(searchVal)
  appSearchValue: searchVal

mapDispatchToProps = (dispatch) ->
  onAppNameSelected: (app) -> dispatch appSelected app.name, app.version
  onAppSearchEntered: (value) -> dispatch appSearchChanged value
  onNewAppClicked: -> dispatch goToNewAppPage()

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../AppsPage.cjsx'
