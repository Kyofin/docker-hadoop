#!/bin/bash

docker tag doris-standalone:latest peterpoker/doris-standalone:latest

docker push  peterpoker/doris-standalone:latest
