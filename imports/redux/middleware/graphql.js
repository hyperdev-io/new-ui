/*
 Redux middleware that implements actions as Graphql side-effects
*/
import _                    from 'lodash'
import gql                  from 'graphql-tag'
import { ApolloClient }     from 'apollo-client'
import { HttpLink }         from 'apollo-link-http'
import { InMemoryCache }    from 'apollo-cache-inmemory'

const appsQuery = gql`
  {apps {
    id
    name
    version
    dockerCompose
    bigboatCompose
    tags
  }}
`

const instancesQuery = gql`
  {instances {
    id
    name
    agent {url}
    app {name, version}
    storageBucket
    startedBy
    state
    desiredState
    status
    services {
      name
      fqdn
      ip
      state
      errors
      logs{n1000}
      container{id, name, created, node}
      ports
    }
  }}
`
const bucketsQuery = gql`
  {buckets {
    id
    name
    isLocked
  }}
`

const dataStoresQuery = gql`
  {datastores {
    id
    name
    percentage
    total
    used
    createdAt
  }}
`

const addId = x => Object.assign({_id: x.id}, x)

module.exports = ({ getState, dispatch }) => {
  console.log('init graphql middleware')
  const client = new ApolloClient({
    link: new HttpLink({ uri: 'http://localhost:3000/graphql' }),
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

  return next => action => {
    next(action)
  }
}
