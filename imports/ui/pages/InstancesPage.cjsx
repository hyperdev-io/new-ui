{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
G                   = require 'grommet'
_                   = require 'lodash'
{ browserHistory }  = require 'react-router'
Helpers             = require '../Helpers.coffee'

module.exports = ({instances}) ->
    sortedInstances = _.sortBy instances, ['name']
    groups = _.values _.groupBy sortedInstances, (i) -> i.name[0]
    <G.Section pad='none'>
      {groups.map (group) ->
        groupName = group[0].name[0].toUpperCase()
        <span key={groupName}>
          <G.Header size='small' justify='start' separator='top' pad={horizontal:'small'}>
            <G.Label size='small'>{groupName}</G.Label>
          </G.Header>
          <G.Tiles selectable=true pad={horizontal:'small'} fill=false flush=false responsive=false>
            {group.map (instance) ->
              onTileClick = -> browserHistory.push "/instances/#{instance.name}"
              instanceHelper = Helpers.withInstance instance
              <G.Tile key={instance._id} align='stretch' pad='small' direction='row' size={width: {min: 'small'}} onClick={onTileClick}>
                <G.Box>
                  <strong>{instance.name}</strong>
                  <G.Box direction='row'>
                    <G.Icons.Status value={instanceHelper.getStateValue()} size='small' />
                    <span className='secondary'>{instanceHelper.getStatusText()}</span>
                  </G.Box>
                </G.Box>
              </G.Tile>
            }
          </G.Tiles>
        </span>
      }
    </G.Section>
