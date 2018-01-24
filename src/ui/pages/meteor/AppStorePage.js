var _, appstoreSearchChanged, connect, mapDispatchToProps, mapStateToProps;

_ = require('lodash');

({connect} = require('react-redux'));

({ appstoreSearchChanged } = require("../../../redux/actions/search"));

mapStateToProps = function(state) {
  var apps, ref, searchVal;
  apps = state.collections.appstore_apps || [];
  searchVal = ((ref = state.search) != null ? ref.appstore_search : void 0) || '';
  return {
    searchValue: searchVal,
    totalResults: (_.values(_.groupBy(apps, function(i) {
      return i.name;
    }))).length,
    apps: _.filter(apps, function(app) {
      var ref1;
      return (ref1 = app.name) != null ? ref1.match(searchVal) : void 0;
    })
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onAppStoreSearchChanged: function(value) {
      return dispatch(appstoreSearchChanged(value));
    },
    onClearSearch: function() {
      return dispatch(appstoreSearchChanged(''));
    }
  };
};

module.exports = connect(mapStateToProps, mapDispatchToProps)(require('../AppStorePage'));
