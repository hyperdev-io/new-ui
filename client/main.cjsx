React               = require 'react'
{ Meteor }          = require 'meteor/meteor'
{ Session }         = require 'meteor/session'
{ createContainer } = require 'meteor/react-meteor-data'
{ render }          = require 'react-dom'
{ browserHistory }  = require 'react-router'
{ createStore, combineReducers, applyMiddleware, compose } = require 'redux'
{ routerReducer } = require 'react-router-redux'
{ EventEmitter }    = require 'fbemitter'
_                   = require 'lodash'
routes              = require '../imports/startup/routes.cjsx'
ErrorMapper         = require '../imports/ErrorMapper.coffee'

# Wrapper = React.createClass
#   displayName: 'MeteorDataWrapper'
#
#   render: -> routes @props
#
# WrappedWrapper = createContainer (props) ->
#
#   ddp = DDP.connect Meteor.settings.public.ddpServer
#   Meteor.remoteConnection = ddp
#   Accounts.connection = ddp
#   Meteor.users = new Mongo.Collection 'users',  connection: ddp
#   Accounts.users = Meteor.users
#   eventEmitter = new EventEmitter
#
#   Tracker.autorun ->
#     token = sessionStorage.getItem('_storedLoginToken')
#     if token
#       Meteor.loginWithToken token, (err) ->
#         console.log('loginWithToken ',token) unless err
#         console.log('loginWithTokenError ',err) if err
#
#   Tracker.autorun ->
#     user = Meteor.user()
#     if user
#       console.log('set token', Accounts._storedLoginToken())
#       sessionStorage.setItem('_storedLoginToken', Accounts._storedLoginToken());
#
#   storeDataInSession = (sessVar) -> (data) ->
#     console.log 'Session.set', sessVar, data
#     Session.set sessVar, data
#
#   onEvent = (eventName, callbacks...) ->
#     eventEmitter.addListener eventName, -> console.log "Event '#{eventName}' happened"
#     eventEmitter.addListener eventName, cb for cb in callbacks
#
#   onEvent 'app name selected', storeDataInSession('selectedAppName'), (app) -> browserHistory.push("/apps/#{app.name}/#{app.version}")
#   onEvent 'app search entered', storeDataInSession('appSearchValue')
#   onEvent 'stop instance', (instanceName) -> ddp.call 'stopInstance', instanceName
#   onEvent 'save app', (app, dockerCompose, bigboatCompose) ->
#     ddp.call 'saveApp', app.name, app.version, {raw: dockerCompose}, {raw: bigboatCompose}, (err) ->
#       eventEmitter.emit 'show error message', err if err
#   onEvent 'remove app', (app) -> ddp.call 'deleteApp', app.name, app.version, (err) ->
#     eventEmitter.emit 'show error message', err if err
#     eventEmitter.emit 'app removed', app unless err
#   onEvent 'app removed', (app) ->
#     eventEmitter.emit 'show info message', "App #{app.name}:#{app.version} is deleted."
#     browserHistory.push '/apps'
#   onEvent 'start app', (app) -> browserHistory.push("/instance/new/#{app.name}/#{app.version}")
#   onEvent 'NewIntancePage::app selected', (name, version) -> browserHistory.push("/instance/new/#{name}/#{version}")
#   onEvent 'NewInstancePage::state changed', (name, version, pstate) ->
#     state = _.merge (Session.get('NewInstancePageState') or {}), pstate
#     query = _.toPairs(state).map(([key, val]) -> "#{key}=#{val}").join "&"
#     Session.set 'NewInstancePageState', state
#     browserHistory.push("/instance/new/#{name}/#{version}?#{query}")
#
#
#   onEvent 'show error message', (message) -> Session.set 'globalErrorMessage', ErrorMapper message
#   onEvent 'clear error message', -> Session.set 'globalErrorMessage', null
#   onEvent 'show info message', (message) -> Session.set 'globalInfoMessage', message
#   onEvent 'clear info message', -> Session.set 'globalInfoMessage', null
#
#
#   emit: (evt, data...) -> eventEmitter.emit.apply eventEmitter, [evt].concat data
#   collections:
#     Instances: new Mongo.Collection 'instances', connection: ddp
#     Apps: new Mongo.Collection 'applicationDefs', connection: ddp
#     StorageBuckets: new Mongo.Collection 'storageBuckets', connection: ddp
#     DataStores: new Mongo.Collection 'datastores',  connection: ddp
#     Users: Meteor.users
#   subscribe:
#     allInstances: -> ddp.subscribe 'instances'
#     allApps: -> ddp.subscribe 'applicationDefs'
#     allStorageBuckets: -> ddp.subscribe 'storage'
#     allDataStores: -> ddp.subscribe 'datastores'
#     allUsers: -> ddp.subscribe 'allUsers'
#   state:
#     selectedAppName: -> Session.get 'selectedAppName'
#     appSearchValue: -> Session.get 'appSearchValue'
#     globalErrorMessage: -> Session.get 'globalErrorMessage'
#     globalInfoMessage: -> Session.get 'globalInfoMessage'
#     isLoggedIn: -> Meteor.userId()?
#     user: -> Meteor.user()
#
# , Wrapper

myReducer = (state = {}, action) ->
  console.log 'action', action
  console.log 'myReducer state', state
  state = routerReducer state, action
  x = switch action.type
    when 'USER_CHANGED' then Object.assign {}, state, user: action.user
    when 'APPS' then Object.assign {}, state, apps: action.apps
    when 'APP_SEARCH_CHANGED' then Object.assign {}, state, app_search: action.value
    # when 'APP_SELECTED' then browserHistory.push "/apps/#{action.value.name}/#{action.value.version}"

  if x then x else state

init =
  globalErrorMessage: null

navigationMiddleware = ({ getState, dispatch }) -> (next) -> (action) ->
  console.log 'middleware::will dispatch', action
  switch action.type
    when 'APP_SELECTED' then browserHistory.push "/apps/#{action.value.name}/#{action.value.version}"
    else next action

composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose
store = createStore myReducer, init, composeEnhancers applyMiddleware(navigationMiddleware)


# url = null
# store.subscribe ->
#   state = store.getState()
#   console.log 'old url vs new url', url, state.url
#   if state.url and url != state.url
#     url = state.url
#     browserHistory.push state.url


Meteor.startup ->
  ddp = DDP.connect Meteor.settings.public.ddpServer
  Meteor.remoteConnection = ddp
  Accounts.connection = ddp
  Meteor.users = new Mongo.Collection 'users',  connection: ddp
  Accounts.users = Meteor.users

  Apps = new Mongo.Collection 'applicationDefs', connection: ddp
  ddp.subscribe 'applicationDefs'

  Tracker.autorun ->
    store.dispatch type: 'USER_CHANGED', user: Meteor.user()

  Tracker.autorun ->
    apps = Apps.find({}, sort: name: 1, version: 1).fetch()
    console.log 'apps', apps
    store.dispatch type: 'APPS', apps: apps

  # render <WrappedWrapper />, document.getElementById 'render-target'
  render routes(store, {}), document.getElementById 'render-target'
