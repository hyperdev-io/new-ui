const React = require("react");
const { render } = require("react-dom");
const { browserHistory } = require("react-router");
const { createStore, combineReducers, compose } = require("redux");
const { routerReducer } = require("react-router-redux");
const _ = require("lodash");
const reactNotify = require("react-notification-system-redux");
const routes = require("./startup/routes");
const ErrorMapper = require("./ErrorMapper.coffee");
// require("coffeescript/register");


const init = {};

const composeEnhancers =
window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const reducers = combineReducers(
Object.assign(require("./redux/reducers/index.coffee"), {
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