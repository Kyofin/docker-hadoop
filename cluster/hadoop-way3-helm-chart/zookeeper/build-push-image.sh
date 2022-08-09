#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

docker pull zookeeper:3.5.5
docker tag zookeeper:3.5.5  registry.mufankong.top/bigdata/zookeeper:3.5.5
docker push registry.mufankong.top/bigdata/zookeeper:3.5.5
