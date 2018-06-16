/*
 Redux middleware that implements actions as side-effects
*/
import _ from "lodash";
import { goToAppsPage } from "../actions/navigation";
import {
  appSavedNotification,
  appRemovedNotification,
  instanceStopRequestedNotification
} from "../actions/notifications";

import {
  client as BigboatClient,
  subscriptions as BigBoatSubscriptions
} from "@hyperdev-io/server-client";

const addId = x => Object.assign({ _id: x.id }, x);

const location = window.location
const server_api =
  process.env.REACT_APP_SERVER_API ||
  `${location.protocol}//${location.host}/api/graphql`;
const server_ws =
  process.env.REACT_APP_SERVER_WS ||
  `ws://${location.host}/api/subscriptions`;

export default ({ getState, dispatch }) => {
  const bigboatClient = BigboatClient(server_api);
  const bigboatSubscriptions = BigBoatSubscriptions(server_ws);

  const listAndDispatch = (list, type, key) =>
    list.then(data =>
      dispatch(_.fromPairs([["type", type], [key, data.map(addId)]]))
    ).catch(e => console.error(type, e));

  listAndDispatch(bigboatClient.apps.list(), "COLLECTIONS/APPS", "apps");

  listAndDispatch(
    bigboatClient.instances.list(),
    "COLLECTIONS/INSTANCES",
    "instances"
  );
  listAndDispatch(
    bigboatClient.buckets.list(),
    "COLLECTIONS/BUCKETS",
    "buckets"
  );
  listAndDispatch(
    bigboatClient.datastores.list(),
    "COLLECTIONS/DATASTORE",
    "dataStore"
  );
  listAndDispatch(
    bigboatClient.resources.list(),
    "COLLECTIONS/SERVICES",
    "resources"
  );
  listAndDispatch(
    bigboatClient.appstoreapps.list(),
    "COLLECTIONS/APPSTORE",
    "apps"
  );

  bigboatSubscriptions.instances(instances =>
    dispatch({ type: "COLLECTIONS/INSTANCES", instances: instances.map(addId) })
  );
  bigboatSubscriptions.apps(apps =>
    dispatch({ type: "COLLECTIONS/APPS", apps: apps.map(addId) })
  );
  bigboatSubscriptions.buckets(buckets =>
    dispatch({ type: "COLLECTIONS/BUCKETS", buckets: buckets.map(addId) })
  );
  bigboatSubscriptions.resources(resources =>
    dispatch({ type: "COLLECTIONS/RESOURCES", resources: resources })
  );

  return next => async action => {
    switch (action.type) {
      case "SAVE_APP_REQUEST": {
        const app = await bigboatClient.apps.createOrUpdate(
          action.app.name,
          action.app.version,
          action.dockerCompose,
          action.bigboatCompose
        );
        dispatch(appSavedNotification(app));
        break;
      }
      case "REMOVE_APP_REQUEST": {
        await bigboatClient.apps.remove(action.app.name, action.app.version);
        dispatch(goToAppsPage());
        dispatch(appRemovedNotification(action.app));
        break;
      }
      case "START_APP_REQUEST": {
        await bigboatClient.instances.start(
          action.instanceName,
          action.app.name,
          action.app.version,
          {},
          { storageBucket: action.instanceName }
        );
        break;
      }
      case "StopInstanceRequest": {
        await bigboatClient.instances.stop(action.instanceName);
        dispatch(instanceStopRequestedNotification(action.instanceName));
        break;
      }
      case "GetServiceLogs": {
        try {
          const log = await bigboatClient.instances.serviceLogs(action.instance, action.service);
          dispatch({ type: "COLLECTIONS/LOG", log })
        } catch(e) {
          console.error(e);
        }
        break;
      }
      case "DeleteBucketRequest": {
        await bigboatClient.buckets.remove(action.bucket);
        break;
      }
      case "CopyBucketRequest": {
        await bigboatClient.buckets.copy(action.fromBucket, action.toBucket);
        break;
      }
      default: {}
    }
    next(action);
  };
};
