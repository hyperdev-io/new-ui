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
  var endpoint, fqdn, port, protocol, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9;
  port = findWebPort((ref = instance.services) != null ? ref.www : void 0);
  endpoint = ((ref1 = instance.services) != null ? (ref2 = ref1.www) != null ? (ref3 = ref2.properties) != null ? (ref4 = ref3.bigboat) != null ? (ref5 = ref4.instance) != null ? (ref6 = ref5.endpoint) != null ? ref6.path : void 0 : void 0 : void 0 : void 0 : void 0 : void 0) || ":" + port;
  protocol = ((ref7 = instance.services) != null ? (ref8 = ref7.www) != null ? (ref9 = ref8.properties) != null ? (ref10 = ref9.bigboat) != null ? (ref11 = ref10.instance) != null ? (ref12 = ref11.endpoint) != null ? ref12.protocol : void 0 : void 0 : void 0 : void 0 : void 0 : void 0) || determineProtocol(port);
  if (fqdn = (ref13 = instance.services) != null ? (ref14 = ref13.www) != null ? ref14.fqdn : void 0 : void 0) {
    return `${protocol}://${fqdn}${endpoint}`;
  }
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
    startedBy: {
      fullname: `${(startByUser != null ? (ref = startByUser.profile) != null ? ref.firstname : void 0 : void 0)} ${(startByUser != null ? (ref1 = startByUser.profile) != null ? ref1.lastname : void 0 : void 0)}`,
      email: startByUser != null ? (ref2 = startByUser.profile) != null ? ref2.email : void 0 : void 0,
      gravatar: (startByUser != null ? (ref3 = startByUser.profile) != null ? ref3.email : void 0 : void 0) != null ? `http://www.gravatar.com/avatar/${md5(startByUser != null ? (ref4 = startByUser.profile) != null ? ref4.email : void 0 : void 0)}` : void 0
    }
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

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps)(require('../InstanceDetailPage'));
