

import Auth from "./auth"
const { render } = require("react-dom");
const { createStore, combineReducers, compose } = require("redux");
const { routerReducer } = require("react-router-redux");
const reactNotify = require("react-notification-system-redux");
const routes = require("./startup/routes");

const auth = new Auth();

if(/access_token|id_token|error/.test(window.location.hash)) {
    auth.handleAuthentication();
    console.log("auth.isAuthenticated", auth.isAuthenticated())
} else if(!auth.isAuthenticated()){
    auth.login()
} else {
  const init = {};
  const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
  const reducers = combineReducers(
    Object.assign(require("./redux/reducers/index"), {
      router: routerReducer,
      notifications: reactNotify.reducer
    })
  );

  const store = createStore(
    reducers,
    init,
    composeEnhancers(require("./redux/middleware")())
  );
  render(routes(store, {}), document.getElementById("render-target"));

  auth.getProfile((err, profile) => {
    store.dispatch({type: "USER_PROFILE", profile})
  })
}