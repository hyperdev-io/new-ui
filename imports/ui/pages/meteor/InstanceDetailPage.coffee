_           = require 'lodash'
{ connect } = require 'react-redux'
md5         = require 'md5'
{ stopInstanceRequest } = require '/imports/redux/actions/instance.coffee'
{ appSelected } = require '/imports/redux/actions/apps.coffee'
{ openBucketPageRequest } = require '/imports/redux/actions/buckets.coffee'
{ goToInstanceDetailsPage } = require '/imports/redux/actions/navigation.coffee'

HTTPS_PORTS = ['443', '8443']
HTTP_PORTS = ['80', '4567', '8000', '8080', '8081', '8181', '8668', '9000']

findWebPort = (service) ->
  p = 80
  service?.ports?.forEach (port) ->
    port = port.split('/')[0]
    if port in HTTPS_PORTS.concat(HTTP_PORTS) then p = port
  p
determineProtocol = (port) ->
  if port in HTTPS_PORTS
    "https"
  else
    "http"
instanceLink = (instance) ->
  port = findWebPort instance.services?.www
  endpoint = instance.services?.www?.properties?.bigboat?.instance?.endpoint?.path or ":" + port
  protocol = instance.services?.www?.properties?.bigboat?.instance?.endpoint?.protocol or determineProtocol port
  if fqdn = instance.services?.www?.fqdn
    "#{protocol}://#{fqdn}#{endpoint}"

findServiceLinks = (instance) ->
  _.mapValues instance?.services, (s) ->
    port = findWebPort s
    endpoint = s.endpoint?.path or ":" + port
    protocol = s.endpoint?.protocol or determineProtocol port
    "#{protocol}://#{s.fqdn}#{endpoint}"

mapStateToProps = (state, { params }) ->
  instance = _.find state.collections.instances, {name: params.name}
  startByUser = _.find state.collections.users, {_id: instance?.startedBy}
  title: instance?.name
  instance: instance
  notFound: not instance?
  showLogs: params.type is 'logs'
  service: params.service
  serviceLinks: findServiceLinks instance
  log: state.collections.log
  instanceLink: instanceLink instance if instance
  startedBy:
    fullname: "#{startByUser?.profile?.firstname} #{startByUser?.profile?.lastname}"
    email: startByUser?.profile?.email
    gravatar: "http://www.gravatar.com/avatar/#{md5(startByUser?.profile?.email)}" if startByUser?.profile?.email?


mapDispatchToProps = (dispatch) ->
  onStopInstance: (instanceName) -> dispatch stopInstanceRequest instanceName
  onOpenAppPage: (name, version)-> dispatch appSelected name, version
  onOpenBucketPage: (name) -> dispatch openBucketPageRequest name
  onLogClose: (name) -> dispatch goToInstanceDetailsPage name

mergeProps = (stateProps, dispatchProps, ownProps) ->
  Object.assign {}, stateProps, dispatchProps, ownProps,
    onStopInstance: -> dispatchProps.onStopInstance stateProps.instance.name
    onOpenAppPage: -> dispatchProps.onOpenAppPage stateProps.instance?.app?.name, stateProps.instance?.app?.version
    onOpenBucketPage: -> dispatchProps.onOpenBucketPage stateProps.instance?.storageBucket
    onLogClose: -> dispatchProps.onLogClose stateProps.instance.name

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../InstanceDetailPage'
