const _ = require("lodash");

const menu = require("./menu");
const apps = require("./apps");

module.exports = _.merge({}, menu, apps);
