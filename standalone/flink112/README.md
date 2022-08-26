# Standalone Flink
## 前提
docker要设置内存大于8G。

## 介绍
使用Standalone Flink可以在本地快速搭建hadoop和flink环境，方便多版本flink调试开发。
内置服务版本：
- Jdk 1.8
- Hadoop 2.7.3
- Hive 2.3.9
- Flink 1.12.7
- MySQL 5.1.73
## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- NameNode, DataNode
- ResourceManager, NodeManager
- MySQL

```shell script
docker run  -d  \
-m 8G \
-p 4040:4040 \
-p 2208:22 \
-p 13306:3306 \
-p 7070:7070 \
-p 8088:8088 \
-p 50070:50070 \
-p 8032:8032 \
-p 8042:8042 \
-p 2181:2181 \
--name flink112-all-in-one \
flink112-all-in-one:1.0
```
MYSQL默认账号密码：root/123456。
ssh默认账号密码：root/123456。

启动容器后，可以打开下面页面在浏览器中：
- HDFS NameNode Web UI: [http://127.0.0.1:50070](http://127.0.0.1:50070/)
- YARN ResourceManager Web UI: [http://127.0.0.1:8088](http://127.0.0.1:8088/)

## 进入容器内调试
```shell script
> docker exec -it flink112-all-in-one bash




```
