module.exports =
  openBucketPageRequest: (name) ->
    type: 'OpenBucketPageRequest'
    name: name
  copyBucketRequest: (fromBucket, toBucket) ->
    type: 'CopyBucketRequest'
    fromBucket: fromBucket
    toBucket: toBucket
  deleteBucketRequest: (bucket) ->
    type: 'DeleteBucketRequest'
    bucket: bucket
