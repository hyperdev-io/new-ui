import React from 'react';
import {
  Box,
  Button,
  Header,
  Split,
  Sidebar,
  Paragraph,
  Icons,
  ListItem,
  List
} from 'grommet';
import filesize from 'filesize';

import FilterableItemsPage from '../FilterableItemsPage';
import DataStoreUsageMeter from '../viz/DataStoreUsageMeter';
import BucketCopyLayer from '../layers/BucketCopyLayer';
import BucketRemoveLayer from '../layers/BucketRemoveLayer';

const filterFun = (search) => (bucket) => bucket.name.match(search);

const BucketsList = ({ items }) => (
  <List
    selectable={true}
  >
    {items.map(bucket => (
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
            <img src="/img/hourglass.svg" style={{ padding: "0px 35px" }} alt="" />
          )}
        </Box>
      </ListItem>
    ))}
  </List>
);


export default ({ dataStore, buckets, isCopy, onCopy, isDelete, onDelete, selectedBucket, onActionMenuClose }) => (
  <React.Fragment>
    <Split flex="left" priority="left">
      <FilterableItemsPage title="Storage" items={buckets} filterFun={filterFun} >
        <BucketsList />
      </FilterableItemsPage>
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
            <DataStoreUsageMeter used={dataStore.used} free={dataStore.free} />
          </Box>
        </Box>
      </Sidebar>
    </Split>
    <BucketCopyLayer
      hidden={!isCopy}
      selectedBucket={selectedBucket}
      onClose={() => onActionMenuClose(selectedBucket)}
      onSubmit={onCopy}
    />
    <BucketRemoveLayer
      hidden={!isDelete}
      selectedBucket={selectedBucket}
      onClose={() => onActionMenuClose(selectedBucket)}
      onSubmit={onDelete}
    />
  </React.Fragment>
);
