# Standalone Kafka

## 介绍
使用Standalone kafka可以在本地快速搭建kafka环境，并且会一直生成模拟数据插入kafka的topic中方便调试。
`Dockerfile_kafka`内置服务版本：
- Jdk 1.8
- Kafka 1.1.1
- Zookeeper 3.4.6

## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- Zookeeper
- Kafka 

```shell script
docker run -d \
-m 2G \
-p 9092:9092 \
-p 2181:2181 \
--name kafka-gendata \
kafka-gendata:latest
```


## 进入容器内调试
```shell script
> docker exec -it kafka-gendata bash
[root@590d72d0386e admin]# ls
entrypoint_kafka.sh  first_run  gendata  jdk1.8.0_141  kafka_2.11-1.1.1  zookeeper-3.4.6  zookeeper.out

[root@590d72d0386e admin]# jps
962 Jps
18 QuorumPeerMain
37 Kafka

```

## 监听kafka数据打印控制台
```shell script
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic source
```
