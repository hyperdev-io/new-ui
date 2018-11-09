const { applyMiddleware } = require("redux");
const { browserHistory } = require("react-router");
const navigation = require("./navigation");
const bigboat = require("./bigboat").default;
const auth = require("./auth").default;

module.exports = () => applyMiddleware(navigation(browserHistory), auth, bigboat);
