const { Meteor }          = require('meteor/meteor')
const React = require('react')
const FilterableListPage = require('../FilterableListPage')
const AppsList = require('../lists/AppsList')
const { Article, Button, Box, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons, Menu, ListItem } = require('grommet')

module.exports = React.createClass({
  displayName: 'AppsPage',
  renderItem: (app) => {
    return (
      <ListItem key={app._id} pad='medium' justify='between' align='center'>
        <Box direction='column' pad='none'>
          <strong>{app.name}</strong>
          <span>{app.version}</span>
        </Box>
      </ListItem>
    )
  },
  render: function() {
    return (
      <Split flex='left' priority='left'>
        <FilterableListPage title='Apps'
          searchValue={this.props.appSearchValue}
          totalResults={this.props.totalResults}
          items={this.props.items}
          onSearch={this.props.onAppSearchEntered}
          onClearSearch={this.props.onClearSearch}
          onListItemSelected={this.props.onAppNameSelected}
          renderItem={this.renderItem}/>
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
})