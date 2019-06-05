import InstanceDetailPage from '../InstanceDetailPage'

var HTTPS_PORTS, HTTP_PORTS, _, appSelected, connect, determineProtocol, findServiceLinks, findWebPort, goToInstanceDetailsPage, instanceLink, mapDispatchToProps, mapStateToProps, md5, mergeProps, openBucketPageRequest, stopInstanceRequest,
  indexOf = [].indexOf;

_ = require('lodash');

({connect} = require('react-redux'));

md5 = require('md5');

({ stopInstanceRequest } = require("../../../redux/actions/instance"));

({ appSelected } = require("../../../redux/actions/apps"));

({ openBucketPageRequest } = require("../../../redux/actions/buckets"));

({ goToInstanceDetailsPage } = require("../../../redux/actions/navigation"));

HTTPS_PORTS = ['443', '8443'];

HTTP_PORTS = ['80', '4567', '8000', '8080', '8081', '8181', '8668', '9000'];

findWebPort = function(service) {
  var p, ref;
  p = 80;
  if (service != null) {
    if ((ref = service.ports) != null) {
      ref.forEach(function(port) {
        port = port.split('/')[0];
        if (indexOf.call(HTTPS_PORTS.concat(HTTP_PORTS), port) >= 0) {
          return p = port;
        }
      });
    }
  }
  return p;
};

determineProtocol = function(port) {
  if (indexOf.call(HTTPS_PORTS, port) >= 0) {
    return "https";
  } else {
    return "http";
  }
};

instanceLink = function(instance) {
  const port = findWebPort(_.get(instance, 'services.www', null))
  const endpoint = _.get(instance, 'services.www.properties.bigboat.instance.endpoint.path', `:${port}`);
  const protocol = _.get(instance, "services.www.properties.bigboat.instance.endpoint.protocol", determineProtocol(port));
  const fqdn = _.get(instance, "services.www.fqdn", false);

  return fqdn ? `${protocol}://${fqdn}${endpoint}` : null;
};

findServiceLinks = function(instance) {
  return _.mapValues(instance != null ? instance.services : void 0, function(s) {
    var endpoint, port, protocol, ref, ref1;
    port = findWebPort(s);
    endpoint = ((ref = s.endpoint) != null ? ref.path : void 0) || ":" + port;
    protocol = ((ref1 = s.endpoint) != null ? ref1.protocol : void 0) || determineProtocol(port);
    return `${protocol}://${s.fqdn}${endpoint}`;
  });
};

mapStateToProps = function(state, {params}) {
  var instance, ref, ref1, ref2, ref3, ref4, startByUser;
  instance = _.find(state.collections.instances, {
    name: params.name
  });
  startByUser = _.find(state.collections.users, {
    _id: instance != null ? instance.startedBy : void 0
  });
  return {
    title: instance != null ? instance.name : void 0,
    instance: instance,
    notFound: instance == null,
    showLogs: params.type === 'logs',
    service: params.service,
    serviceLinks: findServiceLinks(instance),
    log: state.collections.log,
    instanceLink: instance ? instanceLink(instance) : void 0,
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onStopInstance: function(instanceName) {
      return dispatch(stopInstanceRequest(instanceName));
    },
    onOpenAppPage: function(name, version) {
      return dispatch(appSelected(name, version));
    },
    onOpenBucketPage: function(name) {
      return dispatch(openBucketPageRequest(name));
    },
    onLogClose: function(name) {
      return dispatch(goToInstanceDetailsPage(name));
    }
  };
};

mergeProps = function(stateProps, dispatchProps, ownProps) {
  return Object.assign({}, stateProps, dispatchProps, ownProps, {
    onStopInstance: function() {
      return dispatchProps.onStopInstance(stateProps.instance.name);
    },
    onOpenAppPage: function() {
      var ref, ref1, ref2, ref3;
      return dispatchProps.onOpenAppPage((ref = stateProps.instance) != null ? (ref1 = ref.app) != null ? ref1.name : void 0 : void 0, (ref2 = stateProps.instance) != null ? (ref3 = ref2.app) != null ? ref3.version : void 0 : void 0);
    },
    onOpenBucketPage: function() {
      var ref;
      return dispatchProps.onOpenBucketPage((ref = stateProps.instance) != null ? ref.storageBucket : void 0);
    },
    onLogClose: function() {
      return dispatchProps.onLogClose(stateProps.instance.name);
    }
  });
};

export default connect(mapStateToProps, mapDispatchToProps, mergeProps)(InstanceDetailPage);
