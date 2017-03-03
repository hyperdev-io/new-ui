#!/bin/sh

npm test
RESULT=$?

if [ $RESULT -ne 0 ]; then
  echo ""
  echo "There are test failures, aborting commit.."
  echo ""
  exit 1
else
  exit 0
fi
