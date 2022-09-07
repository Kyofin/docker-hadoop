docker build -t poker/hadoop:2.7.2 .
docker tag poker/hadoop:2.7.2  registry.mufankong.top/bigdata/poker/hadoop:2.7.2
docker push registry.mufankong.top/bigdata/poker/hadoop:2.7.2
