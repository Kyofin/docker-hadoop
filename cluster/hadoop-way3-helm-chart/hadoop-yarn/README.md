## 安装
```shell
 kubectl apply -f . -n bigdata-local
```

## 注意
spark on yarn时，shuffle数据会写到如下目录，如果不设置挂载会导致宿主机硬盘不够。
```shell
359M    ./usercache/root/appcache/application_1660318400963_0002/blockmgr-7b6bdfd2-c476-413c-ac79-5d8a64956d88

```
