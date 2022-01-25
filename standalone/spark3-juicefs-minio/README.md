# spark3集成JuiceFs镜像
## 前提
docker要设置内存大于8G。

## 介绍
该容器会集成spark3，元数据会用spark3内置的hive来存储到mysql中。并且spark3会集成JuiceFS，读写的数据数据都会通过JuiceFS，分解到Minio中
该容器中的spark和hdfs客户端都会以Juice作为defaultFS。

`Dockerfile_spark3-nohive-hudi`内置服务版本：
- Jdk 1.8
- Hadoop 2.7.3
- Spark 3.1.2
- MySQL 5.1.73
- Minio
- JuiceFs 1.0.0-beta1
## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- ResourceManager, NodeManager
- Minio

```shell script
docker run -d \
-m 8G \
-p 4040:4040 \
-p 9001:9001 \
-p 9002:9002 \
-p 13306:3306 \
-p 7070:7070 \
-p 8088:8088 \
-p 50070:50070 \
-p 8032:8032 \
-p 8042:8042 \
-p 2181:2181 \
--name spark3-juicefs-minio \
spark3-juicefs-minio:latest
```
MYSQL默认账号密码：root/123456。

启动容器后，可以打开下面页面在浏览器中：
- HDFS NameNode Web UI: [http://127.0.0.1:50070](http://127.0.0.1:50070/)
- YARN ResourceManager Web UI: [http://127.0.0.1:8088](http://127.0.0.1:8088/)
- Minio Web UI: [http://localhost:9002/login](http://localhost:9002/login)

