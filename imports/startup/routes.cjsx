React = require 'react'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router';

App     = require '../ui/App.cjsx'
Page    = require '../ui/Page.cjsx'
AppsPage            = require '../ui/pages/meteor/AppsPage.coffee'
StoragePage         = require '../ui/pages/meteor/StoragePage.coffee'
InstancesPage       = require '../ui/pages/meteor/InstancesPage.coffee'
InstanceDetailPage  = require '../ui/pages/meteor/InstanceDetailPage.coffee'


module.exports = (props) ->

  <Router history={browserHistory} >
    <Route path="/" component={App}>
      <Route path="apps" component={AppsPage} App={props} />
      <Route path="instances" component={Page} title='Instances'>
        <IndexRoute component={InstancesPage} App={props} />
      </Route>
      <Route path="instances/:name" component={InstanceDetailPage} App={props} />
      <Route path="storage" component={StoragePage} App={props} />
    </Route>
  </Router>
