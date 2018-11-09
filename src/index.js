import root from "./startup/root";
import reducers from './redux/reducers/index'
const { render } = require("react-dom");
const { createStore, combineReducers, compose } = require("redux");
const { routerReducer } = require("react-router-redux");
const reactNotify = require("react-notification-system-redux");

const init = {};

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const combinedReducers = combineReducers(
  Object.assign({}, reducers, {
    router: routerReducer,
    notifications: reactNotify.reducer
  })
);
const store = createStore(
  combinedReducers,
  init,
  composeEnhancers(require("./redux/middleware")())
);

render(root(store), document.getElementById("render-target"));
