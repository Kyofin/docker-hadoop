docker pull juicedata/juicefs-csi-driver:v0.17.1
docker pull quay.io/k8scsi/livenessprobe:v1.1.0
docker pull quay.io/k8scsi/csi-node-driver-registrar:v2.1.0
docker pull quay.io/k8scsi/csi-provisioner:v1.6.0
docker pull juicedata/mount:v1.0.0-4.8.0


docker tag juicedata/juicefs-csi-driver:v0.17.1  registry.mufankong.top/bigdata/juicedata/juicefs-csi-driver:v0.17.1
docker push registry.mufankong.top/bigdata/juicedata/juicefs-csi-driver:v0.17.1

docker tag quay.io/k8scsi/livenessprobe:v1.1.0  registry.mufankong.top/bigdata/quay.io/k8scsi/livenessprobe:v1.1.0
docker push registry.mufankong.top/bigdata/quay.io/k8scsi/livenessprobe:v1.1.0

docker tag quay.io/k8scsi/csi-node-driver-registrar:v2.1.0  registry.mufankong.top/bigdata/quay.io/k8scsi/csi-node-driver-registrar:v2.1.0
docker push registry.mufankong.top/bigdata/quay.io/k8scsi/csi-node-driver-registrar:v2.1.0

docker tag quay.io/k8scsi/csi-provisioner:v1.6.0  registry.mufankong.top/bigdata/quay.io/k8scsi/csi-provisioner:v1.6.0
docker push registry.mufankong.top/bigdata/quay.io/k8scsi/csi-provisioner:v1.6.0


docker tag juicedata/mount:v1.0.0-4.8.0  registry.mufankong.top/bigdata/juicedata/mount:v1.0.0-4.8.0
docker push registry.mufankong.top/bigdata/juicedata/mount:v1.0.0-4.8.0