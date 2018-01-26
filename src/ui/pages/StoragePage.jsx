let Box,
  Button,
  Header,
  Heading,
  Icons,
  ListItem,
  Paragraph,
  Search,
  Sidebar,
  Split,
  Title;
const React = require("react");
const filesize = require("filesize");
const _ = require("lodash");

({
  Box,
  Button,
  Header,
  Heading,
  Search,
  Title,
  Box,
  Split,
  Sidebar,
  Paragraph,
  Icons,
  ListItem
} = require("grommet"));

const DataStoreUsageMeter = require("../viz/DataStoreUsageMeter");
const FilterableListPage = require("../FilterableListPage");
const BucketCopyLayer = require("../layers/BucketCopyLayer");
const BucketRemoveLayer = require("../layers/BucketRemoveLayer");
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: "StoragePage",

  renderBucket: bucket => (
    <ListItem key={bucket._id} pad="medium" justify="between" align="center">
      <Box direction="column" pad="none">
        <span style={{ fontSize: 20 }}>{bucket.name}</span>
      </Box>
      <Box direction="row" pad="none" align="center">
        <span style={{ paddingRight: 20 }}>{filesize(bucket.size || 0)}</span>
        {!bucket.isLocked && (
          <Box direction="row" pad="none">
            <Button
              path={`/storage/${bucket.name}/copy`}
              icon={<Icons.Base.Copy />}
            />
            <Button
              path={`/storage/${bucket.name}/delete`}
              icon={<Icons.Base.Trash />}
              onClick={() => console.log("remove")}
            />
          </Box>
        )}
        {bucket.isLocked && (
          <img src="/img/hourglass.svg" style={{ padding: "0px 35px" }} />
        )}
      </Box>
    </ListItem>
  ),
  render: function() {
    const ds = this.props.dataStore;
    const splitFlex = this.props.selectedAppName ? "right" : "left";

    return (
      <span>
        <Split flex="left" priority="left">
          <FilterableListPage
            title="Storage"
            searchValue={this.props.searchValue}
            totalResults={this.props.totalResults}
            items={this.props.buckets}
            selectedIdx={_.findIndex(
              this.props.buckets,
              b => b.name === this.props.selectedBucket
            )}
            onSearch={this.props.onBucketSearchChanged}
            onClearSearch={this.props.onClearSearch}
            onListItemSelected={this.props.onAppNameSelected}
            renderItem={this.renderBucket}
          />
          <Sidebar size="medium" colorIndex="light-2" direction="column">
            <Box align="center" direction="column">
              <div style={{ borderBottom: "1px solid dimgrey", margin: 20 }}>
                <Header
                  pad="medium"
                  align="start"
                  size="large"
                  direction="column"
                >
                  <Paragraph align="start">
                    <Icons.Base.Info
                      style={{ float: "left", marginTop: 10, marginRight: 10 }}
                    />
                    This page lists all storage buckets in your data store. A
                    storage bucket contains the actual data of an instance.
                    Storage buckets can be copied and deleted. When an instance
                    is stopped the data bucket remains until it is deleted by a
                    user.
                  </Paragraph>
                </Header>
              </div>

              <Box flex={true} justify="center" direction="column">
                <DataStoreUsageMeter used={ds.used} free={ds.free} />
              </Box>
            </Box>
          </Sidebar>
        </Split>
        <BucketCopyLayer
          hidden={!this.props.isCopy}
          selectedBucket={this.props.selectedBucket}
          onClose={() =>
            this.props.onActionMenuClose(this.props.selectedBucket)
          }
          onSubmit={this.props.onCopy}
        />
        <BucketRemoveLayer
          hidden={!this.props.isDelete}
          selectedBucket={this.props.selectedBucket}
          onClose={() =>
            this.props.onActionMenuClose(this.props.selectedBucket)
          }
          onSubmit={this.props.onDelete}
        />
      </span>
    );
  }
});
