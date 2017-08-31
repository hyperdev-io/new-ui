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
ResourcesPage         = require '../ui/pages/meteor/ResourcesPage.coffee'
LoginPage           = require '../ui/pages/meteor/LoginPage.coffee'
NewInstancePage     = require '../ui/pages/meteor/NewInstancePage.coffee'

{ Provider }        = require 'react-redux'

module.exports = (store, props) ->

  history = syncHistoryWithStore(browserHistory, store, selectLocationState: (s)->s.router)

  <Provider store={store}>
    <Router history={history} >
      <Route path="/" component={App}>
        <IndexRoute component={LoginPage} />
        <Route path="login" component={LoginPage} />
        <Route path="apps" component={AppsPage} />
        <Route path="apps/new" component={AppsDetailPage} />
        <Route path="apps/:name/:version" component={AppsDetailPage} />
        <Route path="instances" component={Page} title='Instances'>
          <IndexRoute component={InstancesPage} />
        </Route>
        <Route path="instance/new/:name/:version" component={NewInstancePage} />
        <Route path="instance/new" component={NewInstancePage} />
        <Route path="instances/:name" component={InstanceDetailPage}/>
        <Route path="storage" component={StoragePage}>
          <Route path=":name" />
        </Route>
        <Route path="resources" component={ResourcesPage} />
      </Route>
    </Router>
  </Provider>
