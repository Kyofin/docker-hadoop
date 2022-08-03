docker build -f ./Dockerfile-client -t danisla/hadoop-client:2.7.2  .
docker tag danisla/hadoop-client:2.7.2  registry.mufankong.top/bigdata/danisla/hadoop-client:2.7.2
docker push registry.mufankong.top/bigdata/danisla/hadoop-client:2.7.2
