React = require 'react'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router';

App     = require '../ui/App.cjsx'
Page    = require '../ui/Page.cjsx'
Page1   = require '../ui/pages/Page1.cjsx'
InstancesPage   = require '../ui/pages/Instances.cjsx'

module.exports = ->
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={Page1} />
      <Route path="apps" component={Page} title='Apps'>
        <IndexRoute component={Page1} />
      </Route>
      <Route path="instances" component={Page} title='Instances'>
        <IndexRoute component={InstancesPage} />
      </Route>
    </Route>
  </Router>
