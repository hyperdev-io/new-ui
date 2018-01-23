_ = require 'lodash'
pretty            = require 'prettysize'
{ connect }       = require 'react-redux'

sortByState = (services = []) ->
  _.sortBy services, ['isUp']

mapStateToProps = (state, {params}) ->

  services: services = sortByState state.collections.services
  isLoading: not services?

module.exports = connect(mapStateToProps) require '../ResourcesPage'
