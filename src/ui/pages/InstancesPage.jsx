import React from 'react';
import { browserHistory } from 'react-router';
import _ from 'lodash';
import G from 'grommet';
import Helpers from '../Helpers';
import FilterableItemsPage from '../FilterableItemsPage';

const InstancesView = ({ items }) => {
  const sortedInstances = _.sortBy(items, ['name'])
  const groups = _.values(_.groupBy(sortedInstances, (i) => i.name.toUpperCase()[0]))
  return (
    <G.Section pad='none'>
      {groups.map( group => {
        const groupName = group[0].name[0].toUpperCase()
        return (
          <span key={groupName}>
            <G.Header size='small' justify='start' separator='top' pad={{horizontal:'small'}}>
              <G.Label size='small'>{groupName}</G.Label>
            </G.Header>
            <G.Tiles selectable={true} pad={{horizontal:'small'}} fill={false} flush={false} responsive={false}>
              {group.map( instance => {
                const onTileClick = () => browserHistory.push(`/instances/${instance.name}`)
                const instanceHelper = Helpers.withInstance(instance)
                return (
                  <G.Tile key={instance._id} align='stretch' pad='small' direction='row' size={{width: {min: 'small'}}} onClick={onTileClick}>
                    <G.Box>
                      <strong>{instance.name}</strong>
                      <G.Box direction='row'>
                        <G.Icons.Status value={instanceHelper.getStateValue()} size='medium' style={{marginTop:5, width: 15,height: 15}}/>
                        <span className='secondary'>{instanceHelper.getStatusText()}</span>
                      </G.Box>
                    </G.Box>
                  </G.Tile>
                )
              })}
            </G.Tiles>
          </span>
        )
      })}
    </G.Section>
  )
};

const filterFun = (search) => (item) => item.name.toLowerCase().match(search.toLowerCase()) || item.state.toLowerCase().match(search.toLowerCase());

export default ({ instances }) => (
  <FilterableItemsPage title="Instances" items={instances} filterFun={filterFun}>
    <InstancesView />
  </FilterableItemsPage>
);