docker pull bitnami/kafka:2.8.1-debian-10-r99
docker tag bitnami/kafka:2.8.1-debian-10-r99  registry.mufankong.top/bigdata/kafka:2.8.1-debian-10-r99
docker push registry.mufankong.top/bigdata/kafka:2.8.1-debian-10-r99

docker pull bitnami/jmx-exporter:0.16.1-debian-10-r177
docker tag bitnami/jmx-exporter:0.16.1-debian-10-r177  registry.mufankong.top/bigdata/jmx-exporter:0.16.1-debian-10-r177
docker push registry.mufankong.top/bigdata/jmx-exporter:0.16.1-debian-10-r177
