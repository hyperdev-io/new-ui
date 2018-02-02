const React = require('react')
const _ = require('lodash')
const FilterControl = require('grommet-addons/components/FilterControl')
const { Article, Box, Header, Search, Title, Split, Sidebar} = require('grommet')
const { Section, Tiles, Tile } = require('grommet')

module.exports = ({ apps, totalResults, searchValue, onAppStoreSearchChanged, onClearSearch }) => {
  const _onSearch = evt => onAppStoreSearchChanged(evt.srcElement.value)
  const sortedApps = _.sortBy(apps, ['name', 'version'])
  const groups = _.values(_.groupBy(sortedApps, i => i.name))
  const renderSearchNotification = (searchValue = '') => {
    if (searchValue.length > 0)
      return (
        <Box textAlign='center' pad='large'>
          This list is filtered by <strong>&ldquo;{searchValue}&rdquo;</strong>
        </Box>
      )
  }
  return (
    <Split flex='left' priority ='left'>
      <Article>
        <Header fixed={true} pad='medium'>
          <Title responsive={true} truncate={true}>App Store</Title>
          <Search value={searchValue} onDOMChange={_onSearch} placeHolder='Search...' inline={true} fill={true} size='medium' />
          <FilterControl unfilteredTotal={totalResults} filteredTotal={groups.length} onClick={onClearSearch} />
        </Header>

        <Section pad='none'>
          <Tiles selectable={true} pad={{horizontal:'small'}} fill={false} flush={false} responsive={false}>
          {groups.map((apps) => {
            const {name, version, image } = apps[apps.length - 1]
            const appCount = apps.length > 1 ? ` + ${apps.length-1} more` : ''
            
            return (
              <Tile key={name} align='center' pad='small' direction='column' size={{width: {min: 'small'}}} onClick={null}>
                <div style={{height:100}}>
                  <span style={{height:'100%', display:'inline-block', verticalAlign:'middle'}}></span>
                  <img style={{maxHeight: 100, maxWidth: 150, verticalAlign:'middle'}} src={image} alt={`Icon for ${name}`} />
                </div>
                <Box align='center'>
                  <strong>{name}</strong>
                  <Box direction='row'>
                    <span className='secondary'>{version}{appCount}</span>
                  </Box>
                </Box>
              </Tile>
            )
          })}
          </Tiles>
          {renderSearchNotification(searchValue)}
        </Section>

      </Article>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' direction='column'>
        </Header>
      </Sidebar>
    </Split>
  )
}