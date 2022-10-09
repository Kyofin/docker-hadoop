# flink集成cdc和datalake镜像
## 前提
docker要设置内存大于8G。

## 介绍
该容器会集成spark3，元数据会用spark3内置的hive来存储到mysql中。
并且spark3会集成hudi，可以用于测试spark读写hudi表。
mysql初始化后会生成inventory库，并导入数据，为了方便测试cdc功能，会对products表进行数据更新和删除。
flink作业会将cdc数据写入Iceberg和hudi中，可以通过查看hudi表和iceberg表进行效果对比。


`Dockerfile_flink-mysqlcdc-datalake`内置服务版本：
- Jdk 1.8
- Hadoop 2.7.3
- Spark 3.1.2
- Flink 1.13.5
- MySQL 5.1.73
- Hudi 0.10.0
- Iceberg 0.13.1
## 构建镜像
当前目录下，执行`build_standalone_image.sh`脚本

## 启动容器
一旦镜像构建完成，可以启动容器。启动容器后，会自动启动服务：
- NameNode, DataNode
- ResourceManager, NodeManager
- Flink JobManager
- Flink TaskManager

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
-p 8081:8081 \
-p 2181:2181 \
--name flink-mysqlcdc-datalake \
flink-mysqlcdc-datalake:latest
```
MYSQL默认账号密码：root/123456。

启动容器后，可以打开下面页面在浏览器中：
- HDFS NameNode Web UI: [http://127.0.0.1:50070](http://127.0.0.1:50070/)
- YARN ResourceManager Web UI: [http://127.0.0.1:8088](http://127.0.0.1:8088/)
- Flink Web UI: [http://127.0.0.1:8081](http://127.0.0.1:8081/)

![](http://image-picgo.test.upcdn.net/img/20220218185058.png)

## 使用flink sql client验证Iceberg和hudi表
都正常启动后，使用mysql客户端，执行sql。
```mysql

## 增加、更新、删除测试
insert into products values (999,'ddddd','descccc',2222.22);
update products set weight =2222 where  id = 999;
delete from products where id = 999;

```

####  用flinksql验证mysqlcdc写Iceberg效果
执行`/home/admin/flink-1.13.5/bin/sql-client.sh embedded `。
```sql
CREATE CATALOG hadoop_catalog WITH (
  'type'='iceberg',
  'catalog-type'='hadoop',
  'warehouse'='hdfs:///iceberg/warehouse/path',
  'property-version'='1'
);
  
select * from `hadoop_catalog`.`default`.`t_products`;


```
可以看到事件都能实时还原。
![](http://image-picgo.test.upcdn.net/img/20220225153851.png)

####  用sparkshell验证mysqlcdc写Iceberg效果
执行`/home/admin/spark-3.1.2-bin-hadoop2.7/bin/spark-shell `。
```shell script
val df = spark.read.format("iceberg").load("/iceberg/warehouse/path/default/t_products")
df.show
```
效果如下：
![](http://image-picgo.test.upcdn.net/img/20220225153758.png)


#### 用flinksql验证mysqlcdc写hudi效果
执行`/home/admin/flink-1.13.5/bin/sql-client.sh embedded `。
```sql
CREATE TABLE t_products(
 id INT ,
  name STRING,
  description STRING,
  weight float,
   PRIMARY KEY (id) NOT ENFORCED
)WITH (
  'connector' = 'hudi',
    'table.type' = 'MERGE_ON_READ' ,
  'path' = '/flink/hudi/t_products'
);

select * from  t_products;
```
![](http://image-picgo.test.upcdn.net/img/20220218192429.png)

#### 用sparksql验证mysqlcdc写hudi效果
执行`/home/admin/spark-3.1.2-bin-hadoop2.7/bin/spark-sql `。

```sql
create temp view t_products using hudi options('path'='hdfs:///flink/hudi/t_products');
select * from t_products;
```
![](http://image-picgo.test.upcdn.net/img/20220225154237.png)
