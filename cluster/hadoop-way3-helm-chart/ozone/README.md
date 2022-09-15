## 安装
```shell
kubectl apply -f . -n bigdata-local
kubectl delete -f . -n bigdata-local

```

## 创建挂载和桶
```shell
ozone sh volume create /volume
ozone sh bucket create /volume/bucket
```

## 测试
```shell
ozone fs -ls /

```