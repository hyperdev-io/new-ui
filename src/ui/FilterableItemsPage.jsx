import React, { useState } from 'react';
import { Article, Box, Header, Search, Title } from 'grommet';
import FilterControl from 'grommet-addons/components/FilterControl';

export default ({ title, items = [], filterFun, children }) => {
  const [searchValue, setSearchValue] = useState('');
  let filteredItems = items;
  if (searchValue) {
    filteredItems = items.filter(filterFun(searchValue))
  }
  return (
    <Article>
      <Header fixed={true} pad="medium">
        <Title responsive={true} truncate={true}>{title}</Title>
        <Search
          inline={true}
          fill={true}
          value={searchValue}
          onDOMChange={evt => setSearchValue(evt.target.value)}
          placeHolder="Search..."
          size="medium"
        />
        <FilterControl
          unfilteredTotal={items.length}
          filteredTotal={filteredItems.length}
          onClick={() => setSearchValue('')}
        />
      </Header>
      {searchValue.length > 0 && filteredItems.length >= 8 && (
        <Box textAlign="center" pad="large">
          This list is filtered by <strong>&ldquo;{searchValue}&rdquo;</strong>
        </Box>
      )}
      {React.Children.map(children, child => React.cloneElement(child, { items: filteredItems }))}
      {searchValue.length > 0 && (
        <Box textAlign="center" pad="large">
          This list is filtered by <strong>&ldquo;{searchValue}&rdquo;</strong>
        </Box>
      )}
    </Article>
  );
};
