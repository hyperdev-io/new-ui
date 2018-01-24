var _, appSearchChanged, appSelected, connect, goToNewAppPage, mapDispatchToProps, mapStateToProps;

_ = require('lodash');

({connect} = require('react-redux'));

({appSelected} = require('../../../redux/actions/apps'));

({ appSearchChanged } = require("../../../redux/actions/search"));

({ goToNewAppPage } = require("../../../redux/actions/navigation"));

mapStateToProps = function(state) {
  var ref, ref1, searchVal;
  searchVal = ((ref = state.search) != null ? ref.app_search : void 0) || '';
  return {
    appSearchValue: searchVal,
    totalResults: ((ref1 = state.collections.apps) != null ? ref1.length : void 0) || 0,
    items: _.filter(state.collections.apps, function(app) {
      var ref2, ref3;
      return ((ref2 = app.name) != null ? ref2.match(searchVal) : void 0) || ((ref3 = app.version) != null ? ref3.match(searchVal) : void 0);
    })
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onAppNameSelected: function(app) {
      return dispatch(appSelected(app.name, app.version));
    },
    onAppSearchEntered: function(value) {
      return dispatch(appSearchChanged(value));
    },
    onNewAppClicked: function() {
      return dispatch(goToNewAppPage());
    },
    onClearSearch: function() {
      return dispatch(appSearchChanged(''));
    }
  };
};

module.exports = connect(mapStateToProps, mapDispatchToProps)(require('../AppsPage'));
