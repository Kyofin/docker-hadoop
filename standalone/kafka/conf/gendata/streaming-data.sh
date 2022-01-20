#!/bin/bash


#every minute
set +e
while true
do
  /home/admin/gendata/gen-data.sh
  sleep 90
done
set -e

