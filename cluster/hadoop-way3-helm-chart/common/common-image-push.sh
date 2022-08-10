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


