
docker build -f ./Dockerfile-fe -t doris-fe:1.1.2  .
docker build -f ./Dockerfile-be -t doris-be:1.1.2  .


docker tag doris-fe:1.1.2  registry.mufankong.top/bigdata/doris-fe:1.1.2
docker push registry.mufankong.top/bigdata/doris-fe:1.1.2


docker tag doris-be:1.1.2  registry.mufankong.top/bigdata/doris-be:1.1.2
docker push registry.mufankong.top/bigdata/doris-be:1.1.2