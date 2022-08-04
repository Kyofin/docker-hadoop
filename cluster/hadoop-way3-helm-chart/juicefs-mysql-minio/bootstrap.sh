#!/bin/bash

echo "ready format juicefs ...."
# format juicefs
juicefs format  --storage $STORAGE \
--bucket $BUCKET \
--access-key $ACCESS_KEY \
--secret-key $SECRET_KEY \
$META_URL \
myjfs

echo "ready start juicefs  gateway...."
juicefs gateway $META_URL :9100
