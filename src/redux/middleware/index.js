const { applyMiddleware } = require('redux');
const { browserHistory }  = require('react-router');
const navigation          = require('./navigation');
const graphql             = require('./graphql').default;

module.exports = () => applyMiddleware(navigation(browserHistory), graphql);
