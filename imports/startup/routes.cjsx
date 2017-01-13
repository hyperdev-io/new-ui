React = require 'react'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router';

App     = require '../ui/App.cjsx'
Page1   = require '../ui/pages/Page1.cjsx'
Page2   = require '../ui/pages/Page2.cjsx'

module.exports = ->
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={Page1} />
      <Route path="page1" component={Page1}/>
      <Route path="page2" component={Page2}/>
    </Route>
  </Router>
