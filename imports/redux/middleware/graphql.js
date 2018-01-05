/*
 Redux middleware that implements actions as Graphql side-effects
*/
import _                    from 'lodash'
import gql                  from 'graphql-tag'
import { ApolloClient }     from 'apollo-client'
import { HttpLink }         from 'apollo-link-http'
import { InMemoryCache }    from 'apollo-cache-inmemory'

import { goToAppsPage }     from '../actions/navigation.coffee'
import { userError }        from '../actions/errors.coffee'
import {
  appSavedNotification,
  appRemovedNotification,
  instanceStopRequestedNotification,
} from '../actions/notifications.coffee'

import {
  appsQuery,
  instancesQuery,
  bucketsQuery,
  dataStoresQuery,
  resourcesQuery,
  appstoreAppsQuery,
} from './graphqlQueries'

import {
  createOrUpdateApp,
  removeApp,
  startApp,
  stopInstance,
} from './graphqlMutations'

const addId = x => Object.assign({_id: x.id}, x)

module.exports = ({ getState, dispatch }) => {
  console.log('init graphql middleware')

  const dispatchErrIfAny = (err) => err ? dispatch(userError(err)) : null

  const client = new ApolloClient({
    link: new HttpLink({ uri: 'http://localhost:3010/graphql' }),
    cache: new InMemoryCache()
  });

  fetchCollectionAndDispatch = (query, dispatchType, f) => {
    client.query({query})
      .then(data => dispatch(Object.assign({type: dispatchType}, f(data))))
      .catch(error => console.error(error));
  }

  fetchCollectionAndDispatch(appsQuery, 'COLLECTIONS/APPS', data => ({apps: data.data.apps.map(addId)}))
  fetchCollectionAndDispatch(instancesQuery, 'COLLECTIONS/INSTANCES', data => ({instances: data.data.instances.map(addId)}))
  fetchCollectionAndDispatch(bucketsQuery, 'COLLECTIONS/BUCKETS', data => ({buckets: data.data.buckets.map(addId)}))
  fetchCollectionAndDispatch(dataStoresQuery, 'COLLECTIONS/DATASTORE', data => ({dataStore: data.data.datastores.map(addId)[0]}))
  fetchCollectionAndDispatch(resourcesQuery, 'COLLECTIONS/SERVICES', data => ({services: data.data.resources.map(addId)}))
  fetchCollectionAndDispatch(appstoreAppsQuery, 'COLLECTIONS/APPSTORE', data => ({apps: data.data.appstoreApps.map(addId)}))

  const mutate = (mutation, variables, thenCb) => client.mutate({mutation, variables}).then(thenCb).catch(dispatchErrIfAny)

  return next => action => {
    switch(action.type){
      case 'SAVE_APP_REQUEST': {
        mutate(createOrUpdateApp, {
          name: action.app.name,
          version: action.app.version,
          dockerCompose: action.dockerCompose,
          bigboatCompose: action.bigboatCompose
        }, res => dispatch(appSavedNotification(res.data.createOrUpdateApp)))
        break
      }
      case 'REMOVE_APP_REQUEST': {
        mutate(removeApp, _.pick(action.app, 'name', 'version'), res => {
          dispatch(goToAppsPage())
          dispatch(appRemovedNotification(action.app))
        })
        break
      }
      case 'START_APP_REQUEST': {
        console.log('start App', action);
        mutate(startApp, {
          name: action.instanceName,
          appName: action.app.name,
          appVersion: action.app.version,
          parameters: {},
          options: {}
        }, res => {
          console.log('done');
        })
        break;
      }
      case 'StopInstanceRequest': {
        mutate(stopInstance, {
          name: action.instanceName
        }, res => {
          dispatch(instanceStopRequestedNotification(action.instanceName))
        })
        break;
      }
    }
    next(action)
  }
}
