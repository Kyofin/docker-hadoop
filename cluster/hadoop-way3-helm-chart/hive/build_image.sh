#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

docker build -f Dockerfile -t hadoop-hive-metastore:2.3.9 .
docker tag hadoop-hive-metastore:2.3.9  registry.mufankong.top/bigdata/hadoop-hive-metastore:2.3.9
docker push registry.mufankong.top/bigdata/hadoop-hive-metastore:2.3.9
