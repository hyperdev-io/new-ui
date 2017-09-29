_ = require 'lodash'
{ connect }           = require 'react-redux'

mapStateToProps = (state) ->
  apps: state.collections.appstore_apps

mapDispatchToProps = (dispatch) ->

module.exports = connect(mapStateToProps, mapDispatchToProps) require '../AppStorePage.cjsx'
