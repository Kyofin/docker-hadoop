## 介绍
启动juicefs gateway。内置使用sqlite做元数据，使用本地硬盘


## 运行
```shell
docker run -d -p 9100:9100 --name juicefs-sqlite juicefs-sqlite:latest
```
