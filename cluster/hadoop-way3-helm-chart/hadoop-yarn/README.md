## 安装
```shell
 kubectl apply -f . -n bigdata-local
```

## 注意
spark on yarn时，shuffle数据会写到如下目录，如果不设置挂载会导致宿主机硬盘不够。
```shell
359M    ./usercache/root/appcache/application_1660318400963_0002/blockmgr-7b6bdfd2-c476-413c-ac79-5d8a64956d88

```
## 使用busybox测试yarn的端口
启动容器test-network，yaml内容如下：
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: test-network
spec:
  template:
    spec:
      containers:
        - name: test-busybox
          image: registry.mufankong.top/library/busybox:1.32
          imagePullPolicy: Always
          command: ['sh', '-xc', 'for i in $(seq 1 180); do  sleep 5; done; ']
      restartPolicy: Never
  backoffLimit: 1
```
启动命令如下
```shell
 kubectl apply -f test-network.yaml  -n bigdata-local
```
成功启动后，进入容器里后可以运行Telnet命令
```shell
telnet bigdata-hadoop-yarn-nm-0.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local 8042
```