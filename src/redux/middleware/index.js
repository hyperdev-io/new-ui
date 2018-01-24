const { applyMiddleware } = require('redux');
const { browserHistory }  = require('react-router');
const navigation          = require('./navigation.coffee');
const graphql             = require('./graphql');

module.exports = () => applyMiddleware(navigation(browserHistory), graphql);
