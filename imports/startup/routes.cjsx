React = require 'react'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router';
{ syncHistoryWithStore } = require 'react-router-redux'

App     = require '../ui/App.cjsx'
Page    = require '../ui/Page.cjsx'
AppsPage            = require '../ui/pages/meteor/AppsPage.coffee'
AppsDetailPage      = require '../ui/pages/meteor/AppsDetailPage.coffee'
InstancesPage       = require '../ui/pages/meteor/InstancesPage.coffee'
InstanceDetailPage  = require '../ui/pages/meteor/InstanceDetailPage.coffee'
StoragePage         = require '../ui/pages/meteor/StoragePage.coffee'
LoginPage           = require '../ui/pages/meteor/LoginPage.coffee'
NewInstancePage     = require '../ui/pages/meteor/NewInstancePage.coffee'

{ Provider }        = require 'react-redux'

module.exports = (store, props) ->

  history = syncHistoryWithStore(browserHistory, store, selectLocationState: (s)->s)

  <Provider store={store}>
    <Router history={history} >
      <Route path="/" component={App} App={props}>
        <IndexRoute component={LoginPage} App={props} />
        <Route path="login" component={LoginPage} App={props} />
        <Route path="apps" component={AppsPage} App={props} />
        <Route path="apps/:name/:version" component={AppsDetailPage} App={props} />
        <Route path="instances" component={Page} title='Instances'>
          <IndexRoute component={InstancesPage} App={props} />
        </Route>
        <Route path="instance/new/:name/:version" component={NewInstancePage} App={props} />
        <Route path="instance/new" component={NewInstancePage} App={props} />
        <Route path="instances/:name" component={InstanceDetailPage} App={props} />
        <Route path="storage" component={StoragePage} App={props} />
      </Route>
    </Router>
  </Provider>
