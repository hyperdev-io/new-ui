import gql from 'graphql-tag'

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

const resourcesQuery = gql`
  {resources {
    id
    name
    lastCheck
    isUp
    description
    details
  }}
`

const appstoreAppsQuery = gql`
  {appstoreApps {
    name
    version
    image
    dockerCompose
    bigboatCompose
  }}
`

export {
    appsQuery,
    instancesQuery,
    bucketsQuery,
    dataStoresQuery,
    resourcesQuery,
    appstoreAppsQuery,
}
