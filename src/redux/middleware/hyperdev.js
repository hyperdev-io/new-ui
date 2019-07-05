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
  userLogoutRequestType
} from '../actions/user';

import {
  client as HyperDevClient,
  subscriptions as HyperDevSubscriptions
} from "@hyperdev-io/graphql-api-client";
import { error as errorAction } from '../actions/errors';

const addId = x => Object.assign({ _id: x.id }, x);

const location = window.location;
const server_api =
  process.env.REACT_APP_SERVER_API ||
  `${location.protocol}//${location.host}/api/graphql`;
const server_ws =
  process.env.REACT_APP_SERVER_WS ||
  `ws://${location.host}/api/subscriptions`;

export default ({ getState, dispatch }) => {
  const onUserError = (error) => {
    if(error.info && error.props){
      dispatch(errorAction(error));
    } else console.debug("Received an unknown error", error);
  }

  let hyperdevClient, hyperdevSubscriptions;

  const createClient = (token) => {
    hyperdevClient = HyperDevClient(server_api, {onUserError, token});
    hyperdevSubscriptions = HyperDevSubscriptions(server_ws, token);

    const listAndDispatch = (list, type, key) =>
      list.then(data =>
        dispatch(_.fromPairs([["type", type], [key, data.map(addId)]]))
      ).catch(e => console.error(type, e));

    listAndDispatch(hyperdevClient.apps.list(), "COLLECTIONS/APPS", "apps");

    listAndDispatch(
      hyperdevClient.instances.list(),
      "COLLECTIONS/INSTANCES",
      "instances"
    );
    listAndDispatch(
      hyperdevClient.buckets.list(),
      "COLLECTIONS/BUCKETS",
      "buckets"
    );
    listAndDispatch(
      hyperdevClient.datastores.list(),
      "COLLECTIONS/DATASTORE",
      "dataStore"
    );
    listAndDispatch(
      hyperdevClient.resources.list(),
      "COLLECTIONS/SERVICES",
      "resources"
    );
    listAndDispatch(
      hyperdevClient.appstoreapps.list(),
      "COLLECTIONS/APPSTORE",
      "apps"
    );

    hyperdevClient.currentUser.get().then(user => dispatch({
      type: 'USER',
      payload: user
    })).catch(e => console.error('currentUser.get()', e));

    hyperdevSubscriptions.instances(instances =>
      dispatch({type: "COLLECTIONS/INSTANCES", instances: instances.map(addId)})
    );
    hyperdevSubscriptions.apps(apps =>
      dispatch({type: "COLLECTIONS/APPS", apps: apps.map(addId)})
    );
    hyperdevSubscriptions.buckets(buckets =>
      dispatch({type: "COLLECTIONS/BUCKETS", buckets: buckets.map(addId)})
    );
    hyperdevSubscriptions.resources(resources =>
      dispatch({type: "COLLECTIONS/RESOURCES", resources: resources})
    );
  };

  return next => async action => {
    if(!hyperdevClient || !hyperdevSubscriptions) {
      createClient(action.token);
    }
    if(hyperdevClient && hyperdevSubscriptions) {
      switch (action.type) {
        case userLogoutRequestType: {
          window.location.href = '/logout';
          break;
        }
        case "SAVE_APP_REQUEST": {
          const app = await hyperdevClient.apps.createOrUpdate(
            action.app.name,
            action.app.version,
            action.dockerCompose,
            action.bigboatCompose
          );
          dispatch(appSavedNotification(app));
          break;
        }
        case "REMOVE_APP_REQUEST": {
          await hyperdevClient.apps.remove(action.app.name, action.app.version);
          dispatch(goToAppsPage());
          dispatch(appRemovedNotification(action.app));
          break;
        }
        case "START_APP_REQUEST": {
          await hyperdevClient.instances.start(
            action.instanceName,
            action.app.name,
            action.app.version,
            {},
            {storageBucket: action.bucket!=null?action.bucket:action.instanceName, stateful: action.stateful}
          );
          break;
        }
        case "StopInstanceRequest": {
          await hyperdevClient.instances.stop(action.instanceName);
          dispatch(instanceStopRequestedNotification(action.instanceName));
          break;
        }
        case "GetServiceLogs": {
          try {
            const log = await hyperdevClient.instances.serviceLogs(action.instance, action.service);
            dispatch({type: "COLLECTIONS/LOG", log})
          } catch (e) {
            console.error(e);
          }
          break;
        }
        case "DeleteBucketRequest": {
          await hyperdevClient.buckets.remove(action.bucket);
          break;
        }
        case "CopyBucketRequest": {
          await hyperdevClient.buckets.copy(action.fromBucket, action.toBucket);
          break;
        }
        default: {

        }
      }
    }
    next(action);
  };
};
