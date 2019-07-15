import React from 'react';
import { Button, Box, Header, Split, Sidebar, Icons, Menu, ListItem, List } from 'grommet';
import createReactClass from 'create-react-class';
import FilterableItemsPage from '../FilterableItemsPage';

const filterFun = (search) => (item) => item.name.toLowerCase().match(search.toLowerCase()) || item.version.toLowerCase().match(search.toLowerCase());

const AppsList = ({ items, onSelect }) => (
  <List
    selectable={true}
    onSelect={idx => onSelect(items[idx])}
  >
    {items.map(item => (
      <ListItem key={item._id} pad='medium' justify='between' align='center'>
        <Box direction='column' pad='none'>
          <strong>{item.name}</strong>
          <span>{item.version}</span>
        </Box>
      </ListItem>
    ))}
  </List>
);

export default createReactClass({
  displayName: 'AppsPage',
  render: function() {
    return (
      <Split flex='left' priority='left'>
        <FilterableItemsPage title="Apps" items={this.props.items} filterFun={filterFun} >
          <AppsList onSelect={this.props.onAppNameSelected} />
        </FilterableItemsPage>
        <Sidebar size='medium' colorIndex='light-2' direction='column'>
          <Header pad='medium' size='large' direction='column'>
          </Header>
          <Menu pad='medium'>
            <Button onClick={this.props.onNewAppClicked} align='start' plain={true} label='New App' icon={<Icons.Base.New />}></Button>
          </Menu>
        </Sidebar>
      </Split>
    )
  }
});
