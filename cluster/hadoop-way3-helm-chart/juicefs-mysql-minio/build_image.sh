#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

docker build -f Dockerfile -t juicefs-mysql-minio:1.0.0-rc2-v2 .
docker tag juicefs-mysql-minio:1.0.0-rc2  registry.mufankong.top/bigdata/juicefs-mysql-minio:1.0.0-rc2-v2
docker push registry.mufankong.top/bigdata/juicefs-mysql-minio:1.0.0-rc2-v2
