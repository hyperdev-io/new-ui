const React = require("react");
const { Router, Route, IndexRoute, browserHistory } = require("react-router");
const { syncHistoryWithStore } = require("react-router-redux");

const App = require("../ui/App");
const Page = require("../ui/Page");
const AppsPage = require("../ui/pages/meteor/AppsPage");
const AppsDetailPage = require("../ui/pages/meteor/AppsDetailPage");
const InstancesPage = require("../ui/pages/meteor/InstancesPage");
const InstanceDetailPage = require("../ui/pages/meteor/InstanceDetailPage");
const ServiceLogPage = require("../ui/pages/meteor/ServiceLogPage");
const StoragePage = require("../ui/pages/meteor/StoragePage");
const ResourcesPage = require("../ui/pages/meteor/ResourcesPage");
const LoginPage = require("../ui/pages/meteor/LoginPage");
const NewInstancePage = require("../ui/pages/meteor/NewInstancePage");
const AppStorePage = require("../ui/pages/meteor/AppStorePage");

const { getServiceLogsRequest } = require("../redux/actions/instance");

const { Provider } = require("react-redux");

module.exports = function(store, props) {
  const history = syncHistoryWithStore(browserHistory, store, {
    selectLocationState(s) {
      return s.router;
    }
  });

  const _onLogPageEnter = ({ params }) =>
    store.dispatch(getServiceLogsRequest(params));

  return (
    <Provider store={store}>
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
          <Route
            path="instance/new/:name/:version"
            component={NewInstancePage}
          />
          <Route path="instance/new" component={NewInstancePage} />
          <Route path="instances/:name" component={InstanceDetailPage} />
          <Route
            path="instances/:name/:service/:type(logs)"
            onEnter={_onLogPageEnter}
            component={ServiceLogPage}
          />
          <Route path="storage" component={StoragePage}>
            <Route path=":name" />
            <Route path=":name/:type(copy|delete)" />
          </Route>
          <Route path="resources" component={ResourcesPage} />
          <Route path="appstore" component={AppStorePage} />
        </Route>
      </Router>
    </Provider>
  );
};
