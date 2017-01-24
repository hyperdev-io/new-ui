{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
G                   = require 'grommet'

{ createContainer } = require 'meteor/react-meteor-data'

ddp = DDP.connect 'http://localhost:3000'
ddp.subscribe 'instances'
Instances = new Mongo.Collection 'instances', connection: ddp

InstancesComp = React.createClass
  displayName: 'Instances'
  render: ->
    console.log
    <G.Section pad='none'>
      <G.Header size='small' justify='start' separator='top' pad={horizontal:'small'}>
        <G.Label size='small'>Today</G.Label>
      </G.Header>
      <G.Tiles selectable=true pad={horizontal:'small'} fill=false flush=false responsive='false'>
        {@props.instances.map (instance) ->
          <G.Tile align='stretch' pad='small' direction='row' size={height: 'auto', width: min: 'small'}>
            <G.Box href='/apps'>
              <strong>{instance.name}</strong>
              <G.Box direction='row'>
                <G.Icons.Status value='OK' size='small' />
                <span className='secondary'>{instance.state}</span>
              </G.Box>
            </G.Box>
          </G.Tile>
        }
      </G.Tiles>
    </G.Section>

module.exports = createContainer (props) ->
  console.table Instances.find().fetch()
  instances: Instances.find().fetch()
, InstancesComp
