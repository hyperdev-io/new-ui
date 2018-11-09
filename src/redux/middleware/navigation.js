// Redux middleware that implements navigation to urls upon certain actions

var generateNewInstanceUrl, replaceOnLocationMatch;

generateNewInstanceUrl = function (action) {
  var key, query, url, val;
  url = `/instance/new/${action.app.name}/${action.app.version}`;
  query = ((function () {
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

replaceOnLocationMatch = function (browserHistory, locationMatch, url) {
  var ref, ref1;
  return (((ref = browserHistory.getCurrentLocation()) != null ? (ref1 = ref.pathname) != null ? ref1.match(locationMatch) : void 0 : void 0) ? browserHistory.replace : browserHistory.push)(url);
};

module.exports = function (browserHistory) {
  return function ({getState, dispatch}) {
    return function (next) {
      return function (action) {
        switch (action.type) {
          case 'APP_SELECTED':
            browserHistory.push(`/apps/${action.value.name}/${action.value.version}`);
            break;
          case 'SHOW_APPS_PAGE':
            browserHistory.replace("/apps");
            break;
          case 'OPEN_NEW_APP_PAGE_REQUEST':
            browserHistory.push("/apps/new");
            break;
          case 'START_APP_FORM_REQUEST':
            replaceOnLocationMatch(browserHistory, "^/instance/new", generateNewInstanceUrl(action));
            break;
          case 'NewInstancePageCloseRequest':
            browserHistory.push(`/apps/${action.app.name}/${action.app.version}`);
            break;
          case 'OpenBucketPageRequest':
            browserHistory.push(`/storage/${action.name}`);
            break;
          case 'OpenInstanceDetailPageRequest':
            browserHistory.push(`/instances/${action.name}`);
            break;
          case "START_APP_REQUEST":
            browserHistory.replace(`/instances/${action.instanceName}`);
            break;
        }
        return next(action);
      };
    };
  };
};
3
