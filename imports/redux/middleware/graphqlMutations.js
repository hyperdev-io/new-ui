import gql from 'graphql-tag'


const createOrUpdateApp = gql`
  mutation createOrUpdateApp(
    $name: String!,
    $version: String!
    $dockerCompose: String!
    $bigboatCompose: String!
  ){
    createOrUpdateApp(
      name: $name
      version: $version
      dockerCompose: $dockerCompose
      bigboatCompose: $bigboatCompose
    ) {
      id
      name
      version
      dockerCompose
      bigboatCompose
      tags
    }
  }
`

const removeApp = gql`
  mutation removeApp(
    $name: String!,
    $version: String!
  ) {removeApp(name:$name, version:$version)}
`
const startApp = gql`
  mutation startInstance($name: String!, $appName: String!, $appVersion: String!, $parameters: JSON, $options: Options) {startInstance(
    name: $name
    appName: $appName
    appVersion: $appVersion
    parameters: $parameters
    options: $options
  ){
    id
  }}
`
const stopInstance = gql`
  mutation stopInstance($name: String!){
    stopInstance(name: $name) {
      name
    }
  }
`

export {
    createOrUpdateApp,
    removeApp,
    startApp,
    stopInstance,
}
