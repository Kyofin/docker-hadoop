docker build -f ./Dockerfile-client -t hadoop-spark-client:h2.7.2-s3.2.1  .
docker tag hadoop-spark-client:h2.7.2-s3.2.1  registry.mufankong.top/bigdata/hadoop-spark-client:h2.7.2-s3.2.1
docker push registry.mufankong.top/bigdata/hadoop-spark-client:h2.7.2-s3.2.1
