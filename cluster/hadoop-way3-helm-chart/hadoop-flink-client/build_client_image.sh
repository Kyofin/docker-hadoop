docker build -f ./Dockerfile-client -t hadoop-flink-client:h2.7.2-f1.12.7  .
docker tag hadoop-flink-client:h2.7.2-f1.12.7  registry.mufankong.top/bigdata/hadoop-flink-client:h2.7.2-f1.12.7
docker push registry.mufankong.top/bigdata/hadoop-flink-client:h2.7.2-f1.12.7
