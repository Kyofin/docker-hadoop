# Standalone Doris
## 前提
docker要设置内存大于8G。

## 介绍
使用Standalone Hadoop可以在本地快速搭建hadoop环境，方便多版本hadoop调试开发。
`Dockerfile_Doris`内置服务版本：
- Jdk 1.8
- Doris 0.14.13.1
- MySQL 5.1.73

## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- Doris FE, Doris Be

```shell script
docker run -d \
-m 8G \
-p 8040:8040 \
-p 9030:9030 \
-p 8030:8030 \
--name doris-standalone \
doris-standalone:latest

```
Doris默认账号密码：root/空密码。

启动容器后，可以打开下面页面在浏览器中：
- Doris FE Web UI: [http://127.0.0.1:8030](http://127.0.0.1:8030)

