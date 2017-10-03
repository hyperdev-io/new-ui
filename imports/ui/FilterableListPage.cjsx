React               = require 'react'
{ Article, Button, Box, Header, Heading, Search, Title, Split, Sidebar, Paragraph, Icons, Menu, List, ListItem} = require 'grommet'
FilterControl = require 'grommet-addons/components/FilterControl'

module.exports = ({title, searchValue, totalResults, items, selectedIdx, onSearch, onClearSearch, renderItem, onListItemSelected}) ->
  _onListItemSelected = (idx) -> onListItemSelected? items?[idx]
  _onSearch = (evt) -> onSearch evt.srcElement.value
  <Article>
    <Header fixed=true pad='medium'>
      <Title responsive=true truncate=true>{title}</Title>
      <Search value={searchValue} onDOMChange={_onSearch} placeHolder='Search...' inline=true fill=true size='medium' />
      <FilterControl unfilteredTotal={totalResults} filteredTotal={items?.length} onClick={onClearSearch} />
    </Header>
    <List selectable=true onSelect={_onListItemSelected} selected={selectedIdx or -1}>
      {items?.map renderItem}
    </List>
    {if searchValue?.length > 0
      <Box textAlign='center' pad='large'>
        This list is filtered by <strong>&ldquo;{searchValue}&rdquo;</strong>
      </Box>
    }
  </Article>
