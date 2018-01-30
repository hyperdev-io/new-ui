/*
 Redux middleware that implements actions as side-effects
*/
import _ from "lodash";
import { goToAppsPage } from "../actions/navigation";
import { userError } from "../actions/errors";
import {
  appSavedNotification,
  appRemovedNotification,
  instanceStopRequestedNotification
} from "../actions/notifications";

import {
  client as BigboatClient,
  subscriptions as BigBoatSubscriptions
} from "@bigboat/server-client";

const addId = x => Object.assign({ _id: x.id }, x);

export default ({ getState, dispatch }) => {
  const bigboatClient = BigboatClient("http://localhost:3010/graphql");
  const bigboatSubscriptions = BigBoatSubscriptions(
    "ws://localhost:3010/subscriptions"
  );
  const dispatchErrIfAny = err => (err ? dispatch(userError(err)) : null);

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
    }
    next(action);
  };
};
