#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

docker build -f Dockerfile-api -t dolphinscheduler-api:3.0.0-beta-2 .
docker build -f Dockerfile-alert -t dolphinscheduler-alert:3.0.0-beta-2 .
docker build -f Dockerfile-master -t dolphinscheduler-master:3.0.0-beta-2 .
docker build -f Dockerfile-worker -t dolphinscheduler-worker:3.0.0-beta-2 .
docker build -f Dockerfile-tools -t dolphinscheduler-tools:3.0.0-beta-2 .


docker tag dolphinscheduler-api:3.0.0-beta-2  registry.mufankong.top/bigdata/dolphinscheduler-api:3.0.0-beta-2
docker tag dolphinscheduler-alert:3.0.0-beta-2  registry.mufankong.top/bigdata/dolphinscheduler-alert-server:3.0.0-beta-2
docker tag dolphinscheduler-master:3.0.0-beta-2  registry.mufankong.top/bigdata/dolphinscheduler-master:3.0.0-beta-2
docker tag dolphinscheduler-worker:3.0.0-beta-2  registry.mufankong.top/bigdata/dolphinscheduler-worker:3.0.0-beta-2
docker tag dolphinscheduler-tools:3.0.0-beta-2  registry.mufankong.top/bigdata/dolphinscheduler-tools:3.0.0-beta-2

docker push registry.mufankong.top/bigdata/dolphinscheduler-api:3.0.0-beta-2
docker push registry.mufankong.top/bigdata/dolphinscheduler-alert-server:3.0.0-beta-2
docker push registry.mufankong.top/bigdata/dolphinscheduler-master:3.0.0-beta-2
docker push registry.mufankong.top/bigdata/dolphinscheduler-worker:3.0.0-beta-2
docker push registry.mufankong.top/bigdata/dolphinscheduler-tools:3.0.0-beta-2

