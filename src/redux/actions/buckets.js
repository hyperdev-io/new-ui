module.exports = {
  openBucketPageRequest: function(name) {
    return {
      type: 'OpenBucketPageRequest',
      name: name
    };
  },
  copyBucketRequest: function(fromBucket, toBucket) {
    return {
      type: 'CopyBucketRequest',
      fromBucket: fromBucket,
      toBucket: toBucket
    };
  },
  deleteBucketRequest: function(bucket) {
    return {
      type: 'DeleteBucketRequest',
      bucket: bucket
    };
  }
};
