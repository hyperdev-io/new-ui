const React = require("react");
const _ = require("lodash");
const { Router, Route, IndexRoute, browserHistory } = require("react-router");
const { syncHistoryWithStore } = require("react-router-redux");

const App = require("../ui/App");
const Page = require("../ui/Page");
const AppsPage = require("../ui/pages/meteor/AppsPage.coffee");
const AppsDetailPage = require("../ui/pages/meteor/AppsDetailPage.coffee");
const InstancesPage = require("../ui/pages/meteor/InstancesPage.coffee");
const InstanceDetailPage = require("../ui/pages/meteor/InstanceDetailPage.coffee");
const ServiceLogPage = require("../ui/pages/meteor/ServiceLogPage.coffee");
const StoragePage = require("../ui/pages/meteor/StoragePage.coffee");
const ResourcesPage = require("../ui/pages/meteor/ResourcesPage.coffee");
const LoginPage = require("../ui/pages/meteor/LoginPage.coffee");
const NewInstancePage = require("../ui/pages/meteor/NewInstancePage.coffee");
const AppStorePage = require("../ui/pages/meteor/AppStorePage.coffee");

const {
  getServiceLogsRequest
} = require("../redux/actions/instance.coffee");

const { Provider } = require("react-redux");

module.exports = function(store, props) {
  const history = syncHistoryWithStore(browserHistory, store, {
    selectLocationState(s) {
      return s.router;
    }
  });

  const _onLogPageEnter = ({ params }) => store.dispatch(getServiceLogsRequest(params))

  return <Provider store={store}>
      <Router history={history}>
        <Route path="/" component={App}>
          <IndexRoute component={LoginPage} />
          <Route path="login" component={LoginPage} />
          <Route path="apps" component={AppsPage} />
          <Route path="apps/new" component={AppsDetailPage} />
          <Route path="apps/:name/:version" component={AppsDetailPage} />
          <Route path="instances" component={Page} title="Instances">
            <IndexRoute component={InstancesPage} />
          </Route>
          <Route path="instance/new/:name/:version" component={NewInstancePage} />
          <Route path="instance/new" component={NewInstancePage} />
          <Route path="instances/:name" component={InstanceDetailPage} />
          <Route path="instances/:name/:service/:type(logs)" onEnter={_onLogPageEnter} component={ServiceLogPage} />
          <Route path="storage" component={StoragePage}>
            <Route path=":name" />
            <Route path=":name/:type(copy|delete)" />
          </Route>
          <Route path="resources" component={ResourcesPage} />
          <Route path="appstore" component={AppStorePage} />
        </Route>
      </Router>
    </Provider>;
};
