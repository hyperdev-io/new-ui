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

export {
    createOrUpdateApp,
    removeApp,
}
