# Standalone Hadoop
## 介绍
使用Standalone Hadoop可以在本地快速搭建hadoop环境，方便多版本hadoop调试开发。
`Dockerfile_spark3`内置服务版本：
- Jdk 1.8
- Hadoop 2.7.3
- Hive 2.3.9
- Spark 3.1.2
- Kafka 1.1.1
- MySQL 5.1.73
- Zookeeper 3.4.6
## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- NameNode, DataNode
- ResourceManager, NodeManager
- Zookeeper(默认关闭)
- Kafka (默认关闭)

```shell script
docker run -d \
-m 8G \
-p 4040:4040 \
-p 13306:3306 \
-p 7070:7070 \
-p 8088:8088 \
-p 50070:50070 \
-p 8032:8032 \
-p 8042:8042 \
-p 2181:2181 \
--name spark3-all-in-one \
spark3-all-in-one:latest
```
MYSQL默认账号密码：root/123456。

启动容器后，可以打开下面页面在浏览器中：
- HDFS NameNode Web UI: [http://127.0.0.1:50070](http://127.0.0.1:50070/)
- YARN ResourceManager Web UI: [http://127.0.0.1:8088](http://127.0.0.1:8088/)

## 进入容器内调试
```shell script
> docker exec -it spark3-all-in-one bash
[root@e53232ca8dc3 admin]# ls
apache-hive-2.3.9-bin  entrypoint_hadoop.sh  jdk1.8.0_141      mysql80-community-release-el7-3.noarch.rpm  zookeeper-3.4.6
apache-maven-3.6.1     hadoop-2.7.3          kafka_2.11-1.1.1  spark-3.1.2-bin-hadoop2.7

[root@e53232ca8dc3 admin]# jps
289 ResourceManager
145 NameNode
450 RunJar
200 DataNode
345 NodeManager
410 JobHistoryServer
637 Jps

```
