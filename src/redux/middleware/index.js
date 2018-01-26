const { applyMiddleware } = require("redux");
const { browserHistory } = require("react-router");
const navigation = require("./navigation");
const bigboat = require("./bigboat").default;

module.exports = () => applyMiddleware(navigation(browserHistory), bigboat);
