const { applyMiddleware } = require("redux");
const { browserHistory } = require("react-router");
const navigation = require("./navigation");
const hyperdev = require("./hyperdev").default;

module.exports = () => applyMiddleware(navigation(browserHistory), hyperdev);
