# 介绍
通过apisix和本地hosts改写，实现在本地访问k8s里的nodemanager的pod。
首先，在k8s集群内部，通过下面DNS是可以访问nodemanager的pod的。即`bigdata-hadoop-yarn-nm-0.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local`。
我们可以通过apisix配置路由，让我们在访问apisix时，它帮我们转发到k8s里的节点。

# 配置本地hosts文件
```shell
10.81.17.129 httpxxxx00.com
10.81.17.129 httpxxxx01.com
10.81.17.129 httpxxxx02.com
10.81.17.129 httpxxxx03.com
10.81.17.129 httpxxxx04.com
10.81.17.129 httpxxxx05.com

```
其中`10.81.17.129`是k8s节点的地址，后面我们加上apisix gateway的NodePort，就可以转发了。

# 配置apisix的upstream
其中`10.81.17.129:31121`是加上apisix gateway的NodePort的地址。
```shell
curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/0' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-0.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn0"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/1' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-1.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn1"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/2' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-2.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn2"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/3' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-3.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn3"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/4' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-4.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn4"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/1' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-1.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn1"
}'


curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/upstreams/5' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "nodes": [
    {
      "host": "bigdata-hadoop-yarn-nm-5.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local",
      "port": 8042,
      "weight": 1
    }
  ],
  "type": "roundrobin",
  "name": "nn5"
}'
```

# 配置apisix的routes
```shell
curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/routes/0' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "uri": "/*",
    "host": "httpxxxx00.com",
  "name": "nn",
  "methods": [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "HEAD",
    "OPTIONS",
    "CONNECT",
    "TRACE"
  ],
  "upstream_id": "0"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/routes/1' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "uri": "/*",
    "host": "httpxxxx01.com",
  "name": "nn",
  "methods": [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "HEAD",
    "OPTIONS",
    "CONNECT",
    "TRACE"
  ],
  "upstream_id": "1"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/routes/2' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "uri": "/*",
    "host": "httpxxxx02.com",
  "name": "nn",
  "methods": [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "HEAD",
    "OPTIONS",
    "CONNECT",
    "TRACE"
  ],
  "upstream_id": "2"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/routes/3' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "uri": "/*",
    "host": "httpxxxx03.com",
  "name": "nn",
  "methods": [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "HEAD",
    "OPTIONS",
    "CONNECT",
    "TRACE"
  ],
  "upstream_id": "3"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/routes/4' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "uri": "/*",
    "host": "httpxxxx04.com",
  "name": "nn",
  "methods": [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "HEAD",
    "OPTIONS",
    "CONNECT",
    "TRACE"
  ],
  "upstream_id": "4"
}'

curl --location --request PUT 'http://10.81.17.129:31121/apisix/admin/routes/5' \
--header 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "uri": "/*",
    "host": "httpxxxx05.com",
  "name": "nn",
  "methods": [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "HEAD",
    "OPTIONS",
    "CONNECT",
    "TRACE"
  ],
  "upstream_id": "5"
}'
```

# 检验结果
在本地浏览器中访问`http://httpxxxx00.com:31121/node/node`，即可通过apisix gateway，将uri转发给nodemanager。
![](http://image-picgo.test.upcdn.net/img/20220827180351.png)