
// Redux middleware that implements navigation to urls upon certain actions

var generateNewInstanceUrl, replaceOnLocationMatch;

generateNewInstanceUrl = function(action) {
  var key, query, url, val;
  url = `/instance/new/${action.app.name}/${action.app.version}`;
  query = ((function() {
    var ref, results;
    ref = action.params;
    results = [];
    for (key in ref) {
      val = ref[key];
      if (val != null) {
        results.push(`${key}=${val}`);
      }
    }
    return results;
  })()).join('&');
  return [url, query].join('?');
};

replaceOnLocationMatch = function(browserHistory, locationMatch, url) {
  var ref, ref1;
  return (((ref = browserHistory.getCurrentLocation()) != null ? (ref1 = ref.pathname) != null ? ref1.match(locationMatch) : void 0 : void 0) ? browserHistory.replace : browserHistory.push)(url);
};

module.exports = function(browserHistory) {
  return function({getState, dispatch}) {
    return function(next) {
      return function(action) {
        switch (action.type) {
          case 'APP_SELECTED':
            return browserHistory.push(`/apps/${action.value.name}/${action.value.version}`);
          case 'SHOW_APPS_PAGE':
            return browserHistory.replace("/apps");
          case 'OPEN_NEW_APP_PAGE_REQUEST':
            return browserHistory.push("/apps/new");
          case 'START_APP_FORM_REQUEST':
            return replaceOnLocationMatch(browserHistory, "^/instance/new", generateNewInstanceUrl(action));
          case 'NewInstancePageCloseRequest':
            return browserHistory.push(`/apps/${action.app.name}/${action.app.version}`);
          case 'OpenBucketPageRequest':
            return browserHistory.push(`/storage/${action.name}`);
          case 'OpenInstanceDetailPageRequest':
            return browserHistory.push(`/instances/${action.name}`);
          default:
            return next(action);
        }
      };
    };
  };
};
