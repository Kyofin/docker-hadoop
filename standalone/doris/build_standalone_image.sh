#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

echo "start build Doris docker image"
docker build -f Dockerfile_Doris -t doris-standalone .
