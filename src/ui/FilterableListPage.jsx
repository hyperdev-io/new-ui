const React = require("react");
const { Article, Box, Header, Search, Title, List } = require("grommet");
const FilterControl = require("grommet-addons/components/FilterControl");

module.exports = function({
  title,
  searchValue,
  totalResults,
  items = [],
  selectedIdx,
  onSearch,
  onClearSearch,
  renderItem,
  onListItemSelected
}) {
  const _onListItemSelected = idx =>
    typeof onListItemSelected === "function"
      ? onListItemSelected(items != null ? items[idx] : undefined)
      : undefined;
  const _onSearch = evt => onSearch(evt.srcElement.value);

  return (
    <Article>
      <Header fixed={true} pad="medium">
        <Title responsive={true} truncate={true}>
          {title}
        </Title>
        <Search
          value={searchValue}
          onDOMChange={_onSearch}
          placeHolder="Search..."
          inline={true}
          fill={true}
          size="medium"
        />
        <FilterControl
          unfilteredTotal={totalResults}
          filteredTotal={items.length}
          onClick={onClearSearch}
        />
      </Header>
      <List
        selectable={true}
        onSelect={_onListItemSelected}
        selected={selectedIdx || -1}
      >
        {items.map(renderItem)}
      </List>
      {searchValue.length > 0 && (
        <Box textAlign="center" pad="large">
          This list is filtered by <strong>&ldquo;{searchValue}&rdquo;</strong>
        </Box>
      )}
    </Article>
  );
};
