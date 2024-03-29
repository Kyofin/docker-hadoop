#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

echo "start build Hadoop docker image"
docker build -f Dockerfile -t flink112-all-in-one:1.0 .
