import App from "../ui/App";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import NewInstancePage from '../ui/pages/redux/NewInstancePage';
import InstancesPage from '../ui/pages/redux/InstancesPage';
import InstanceDetailPage from '../ui/pages/redux/InstanceDetailPage';

const React = require("react");
const { connect } = require('react-redux');
const { Router, Route, IndexRoute, browserHistory } = require("react-router");

const { syncHistoryWithStore } = require("react-router-redux");
const Page = require("../ui/Page");
const AppsPage = require("../ui/pages/redux/AppsPage");
const AppsDetailPage = require("../ui/pages/redux/AppsDetailPage");
const ServiceLogPage = require("../ui/pages/redux/ServiceLogPage");
const StoragePage = require("../ui/pages/redux/StoragePage");
const ResourcesPage = require("../ui/pages/redux/ResourcesPage");
const AppStorePage = require("../ui/pages/redux/AppStorePage");
const LoginPage = require("../ui/pages/redux/LoginPage");

const { getServiceLogs } = require("../redux/actions/instance");

const Routes = ({ store, hasToken }) => {
  const history = syncHistoryWithStore(browserHistory, store, {
    selectLocationState(s) {
      return s.router;
    }
  });

  const _onLogPageEnter = ({ params }) =>
    store.dispatch(getServiceLogs(params));

  if (hasToken) {
    return <React.Fragment>
      <Router history={history}>
        <Route path="/" component={App}>
          <IndexRoute component={AppsPage}/>
          <Route path="apps" component={AppsPage}/>
          <Route path="apps/new" component={AppsDetailPage}/>
          <Route path="apps/:name/:version" component={AppsDetailPage}/>
          <Route path="instances" component={Page} title="Instances">
            <IndexRoute component={InstancesPage}/>
          </Route>
          <Route path="instance/new/:name/:version" component={NewInstancePage}/>
          <Route path="instance/new" component={NewInstancePage}/>
          <Route path="instances/:name" component={InstanceDetailPage}/>
          <Route path="instances/:name/:service/:type(logs)" onEnter={_onLogPageEnter} component={ServiceLogPage}/>
          <Route path="storage" component={StoragePage}>
            <Route path=":name"/>
            <Route path=":name/:type(copy|delete)"/>
          </Route>
          <Route path="resources" component={ResourcesPage}/>
          <Route path="appstore" component={AppStorePage}/>
        </Route>
      </Router>
      <ToastContainer autoClose={5000}/>
    </React.Fragment>;
  } else {
    return <LoginPage />
  }
};


const mapStateToProps = state => ({
  hasToken: state.user && state.user.token
})
const mapDispatchToProps = dispatch => ({

});
export default connect(mapStateToProps, mapDispatchToProps)(Routes);

