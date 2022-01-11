# Standalone Hadoop
## 前提
docker要设置内存大于8G。

## 介绍
使用Standalone Hadoop可以在本地快速搭建hadoop环境，方便多版本hadoop调试开发。
`Dockerfile_spark3_hive1`内置服务版本：
- Jdk 1.8
- Hadoop 2.7.3
- Hive 1.2.1
- Spark 3.1.2
- Kafka 1.1.1
- MySQL 5.1.73
- Zookeeper 3.4.6
- Iceberg 0.12.1

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
-p 10000:10000 \
-p 13306:3306 \
-p 7070:7070 \
-p 8088:8088 \
-p 50070:50070 \
-p 8032:8032 \
-p 8042:8042 \
-p 2181:2181 \
--name spark3-hive1-all-in-one \
spark3-hive1-all-in-one:latest
```
MYSQL默认账号密码：root/123456。

启动容器后，可以打开下面页面在浏览器中：
- HDFS NameNode Web UI: [http://127.0.0.1:50070](http://127.0.0.1:50070/)
- YARN ResourceManager Web UI: [http://127.0.0.1:8088](http://127.0.0.1:8088/)

## 进入容器内调试
```shell script
> docker exec -it spark3-hive1-all-in-one bash
[root@737e7d396e5b admin]# ls
apache-hive-1.2.1-bin  first_run                          jdk1.8.0_141                                spark-3.1.2-bin-hadoop2.7
apache-maven-3.6.1     hadoop-2.7.3                       kafka_2.11-1.1.1                            zookeeper-3.4.6
entrypoint_hadoop.sh   iceberg-spark3-runtime-0.12.1.jar  mysql80-community-release-el7-3.noarch.rpm

[root@737e7d396e5b admin]# jps
352 NodeManager
147 NameNode
293 ResourceManager
2154 Jps
204 DataNode
414 JobHistoryServer
```



## 测试Iceberg0.12.1

```shell script
bin/spark-shell  --master local
```

使用名为spark_catalog的catalog【org.apache.iceberg.spark.SparkSessionCatalog】管理hive表。

```scala
scala> spark.sql("create table hive_t1 (id int)")
scala> spark.sql("insert into hive_t1 values(1),(2)")
scala> spark.table("hive_t1").show
```

![image-20220110190358053](http://image-picgo.test.upcdn.net/img/20220110190358.png)

使用名为local的catalog【org.apache.iceberg.spark.SparkCatalog】管理Iceberg表。

```scala
scala> spark.sql("create table local.default.ice_t1 (id int)")
scala> spark.sql("insert into local.default.ice_t1 values(1),(2),(34)")
scala> spark.table("local.default.ice_t1").show
```

![image-20220110190505570](http://image-picgo.test.upcdn.net/img/20220110190505.png)



