
const React = require("react");
const { Meteor } = require("meteor/meteor");
const { Session } = require("meteor/session");
const { createContainer } = require("meteor/react-meteor-data");
const { render } = require("react-dom");
const { browserHistory } = require("react-router");
const { createStore, combineReducers, compose } = require("redux");
const { routerReducer } = require("react-router-redux");
const { EventEmitter } = require("fbemitter");
const _ = require("lodash");
const reactNotify = require("react-notification-system-redux");
const routes = require("../imports/startup/routes");
const ErrorMapper = require("../imports/ErrorMapper");

Meteor.startup(function() {
  const ddp = DDP.connect(Meteor.settings.public.ddpServer);
  Meteor.remoteConnection = ddp;
  Accounts.connection = ddp;
  Meteor.users = new Mongo.Collection("users", { connection: ddp });
  Accounts.users = Meteor.users;

  Tracker.autorun(function() {
    const token = sessionStorage.getItem("_storedLoginToken");
    if (token) {
      return Meteor.loginWithToken(token, function(err) {
        if (err) {
          return console.log("loginWithTokenError ", err);
        }
      });
    }
  });

  Tracker.autorun(function() {
    const user = Meteor.user();
    if (user) {
      return sessionStorage.setItem(
        "_storedLoginToken",
        Accounts._storedLoginToken()
      );
    }
  });

  const init = {};

  const composeEnhancers =
    window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
  const reducers = combineReducers(
    Object.assign(require("/imports/redux/reducers/index"), {
      router: routerReducer,
      notifications: reactNotify.reducer
    })
  );
  const store = createStore(
    reducers,
    init,
    composeEnhancers(require("/imports/redux/middleware/index")(ddp))
  );

  return render(routes(store, {}), document.getElementById("render-target"));
});