docker build -f ./Dockerfile -t kylin:4.0.2-spark3  .
docker tag kylin:4.0.2-spark3  registry.mufankong.top/bigdata/kylin:4.0.2-spark3
docker push registry.mufankong.top/bigdata/kylin:4.0.2-spark3

