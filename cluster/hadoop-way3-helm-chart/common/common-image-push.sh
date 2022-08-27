## mysql依赖busybox
docker pull busybox:1.32
docker tag busybox:1.32  registry.mufankong.top/library/busybox:1.32
docker push registry.mufankong.top/library/busybox:1.32

## mysql
docker pull mysql:5.7.30
docker tag mysql:5.7.30  registry.mufankong.top/bigdata/mysql:5.7.30
docker push registry.mufankong.top/bigdata/mysql:5.7.30


## minio
docker pull minio/minio:RELEASE.2020-08-08T04-50-06Z
docker tag minio/minio:RELEASE.2020-08-08T04-50-06Z  registry.mufankong.top/bigdata/minio/minio:RELEASE.2020-08-08T04-50-06Z
docker push registry.mufankong.top/bigdata/minio/minio:RELEASE.2020-08-08T04-50-06Z

# 新版minio
docker pull quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z
docker tag quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z  registry.mufankong.top/bigdata/quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z
docker push registry.mufankong.top/bigdata/quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z

docker pull quay.io/minio/mc:RELEASE.2022-07-29T19-17-16Z
docker tag quay.io/minio/mc:RELEASE.2022-07-29T19-17-16Z  registry.mufankong.top/bigdata/quay.io/minio/mc:RELEASE.2022-07-29T19-17-16Z
docker push registry.mufankong.top/bigdata/quay.io/minio/mc:RELEASE.2022-07-29T19-17-16Z

# prometheus
docker pull quay.io/prometheus/prometheus:v2.36.2
docker tag quay.io/prometheus/prometheus:v2.36.2  registry.mufankong.top/bigdata/quay.io/prometheus/prometheus:v2.36.2
docker push registry.mufankong.top/bigdata/quay.io/prometheus/prometheus:v2.36.2

docker pull prom/pushgateway:v1.4.3
docker tag prom/pushgateway:v1.4.3  registry.mufankong.top/bigdata/prom/pushgateway:v1.4.3
docker push registry.mufankong.top/bigdata/prom/pushgateway:v1.4.3

# grafana
docker pull grafana/grafana:9.0.5
docker tag  grafana/grafana:9.0.5  registry.mufankong.top/bigdata/grafana/grafana:9.0.5
docker push registry.mufankong.top/bigdata/grafana/grafana:9.0.5

# redis
docker pull redis:6.0.9
docker tag  redis:6.0.9  registry.mufankong.top/bigdata/redis:6.0.9
docker push registry.mufankong.top/bigdata/redis:6.0.9


# apisix
docker pull apache/apisix:1.5-alpine
docker tag apache/apisix:1.5-alpine registry.mufankong.top/bigdata/apache/apisix:1.5-alpine
docker push registry.mufankong.top/bigdata/apache/apisix:1.5-alpine

# apisix dashboard
#docker pull apache/apisix-dashboard:2.13-alpine
#docker tag apache/apisix-dashboard:2.13-alpine registry.mufankong.top/bigdata/apache/apisix-dashboard:2.13-alpine
#docker push registry.mufankong.top/bigdata/apache/apisix-dashboard:2.13-alpine


# etcd
docker pull kubesphere/etcd:v3.3.12
docker tag kubesphere/etcd:v3.3.12 registry.mufankong.top/bigdata/kubesphere/etcd:v3.3.12
docker push registry.mufankong.top/bigdata/kubesphere/etcd:v3.3.12