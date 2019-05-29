import React from 'react';
import { Provider } from 'react-redux';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import App from "./ui/App";
import NewInstancePage from './ui/pages/redux/NewInstancePage';
import InstancesPage from './ui/pages/redux/InstancesPage';
import InstanceDetailPage from './ui/pages/redux/InstanceDetailPage';
import AboutPage from './ui/pages/AboutPage';
import AppsPage from './ui/pages/redux/AppsPage';
import StoragePage from './ui/pages/redux/StoragePage';
import IFramePage from './ui/pages/IFramePage';

const { syncHistoryWithStore } = require("react-router-redux");
const Page = require("./ui/Page");
const AppsDetailPage = require("./ui/pages/redux/AppsDetailPage");
const ServiceLogPage = require("./ui/pages/redux/ServiceLogPage");
const ResourcesPage = require("./ui/pages/redux/ResourcesPage");
const AppStorePage = require("./ui/pages/redux/AppStorePage");

const { getServiceLogs } = require("./redux/actions/instance");

const routes = (store) => {
  const history = syncHistoryWithStore(browserHistory, store, {
    selectLocationState(s) {
      return s.router;
    }
  });

  const _onLogPageEnter = ({ params }) =>
    store.dispatch(getServiceLogs(params));

  return <Provider store={store}>
    <React.Fragment>
      <Router history={history}>
        <Route path="/" component={App}>
          <IndexRoute component={AppsPage}/>
          <Route path="apps" component={AppsPage}/>
          <Route path="apps/new" component={AppsDetailPage}/>
          <Route path="apps/:name/:version" component={AppsDetailPage}/>
          <Route path="instances" component={InstancesPage}/>
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
          <Route path="about" component={AboutPage}/>
          <Route path="portal" component={IFramePage} iFramePath="_portal" />
          <Route path="token" component={IFramePage} iFramePath="_token" />
        </Route>
      </Router>
      <ToastContainer autoClose={5000} />
    </React.Fragment>
  </Provider>;
};

export default routes;
