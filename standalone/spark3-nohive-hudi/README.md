# spark3集成hudi镜像
## 前提
docker要设置内存大于8G。

## 介绍
使用Standalone Hadoop可以在本地快速搭建hadoop环境，方便多版本hadoop调试开发。
`Dockerfile_spark3`内置服务版本：
- Jdk 1.8
- Hadoop 2.7.3
- Spark 3.1.2
- MySQL 5.1.73
- Hudi 0.10.0
## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- NameNode, DataNode
- ResourceManager, NodeManager
- SparkThriftServer

```shell script
docker run -d \
-m 8G \
-p 4040:4040 \
-p 10000:10000 \
-p 13306:3306 \
-p 7070:7070 \
-p 8088:8088 \
-p 50070:50070 \
-p 8032:8032 \
-p 8042:8042 \
-p 2181:2181 \
--name spark3-nohive-hudi \
spark3-nohive-hudi:latest
```
MYSQL默认账号密码：root/123456。

启动容器后，可以打开下面页面在浏览器中：
- HDFS NameNode Web UI: [http://127.0.0.1:50070](http://127.0.0.1:50070/)
- YARN ResourceManager Web UI: [http://127.0.0.1:8088](http://127.0.0.1:8088/)

## 进入容器内调试
```shell script
>  docker exec -it spark3-nohive-hudi bash


```
