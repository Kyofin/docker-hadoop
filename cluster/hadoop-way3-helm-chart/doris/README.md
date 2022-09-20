# 安装
```shell
kubectl apply -f . -n bigdata-local
kubectl delete -f . -n bigdata-local  
```
# 注册be
```shell

export SQL="ALTER SYSTEM ADD BACKEND '"$POD_NAME".doris-be-service:9050'"
echo $SQL > 1.sql
mysql -h doris-fe-svc -P 9030 -u root < 1.sql

```
执行sql语句，查看注册的be。
```sql
SHOW PROC '/backends';
```

# 清退be
```shell
export SQL="ALTER SYSTEM DECOMMISSION BACKEND  '"$POD_NAME".doris-be-service:9050'"
echo $SQL > 2.sql
mysql -h doris-fe-svc -P 9030 -u root < 2.sql
```


# 测试sql
```sql
CREATE DATABASE example_db;

USE example_db;

CREATE TABLE table1
(
    siteid INT DEFAULT '10',
    citycode SMALLINT,
    username VARCHAR(32) DEFAULT '',
    pv BIGINT SUM DEFAULT '0'
)
AGGREGATE KEY(siteid, citycode, username)
DISTRIBUTED BY HASH(siteid) BUCKETS 10
PROPERTIES("replication_num" = "3");

insert into table1 values(1,1,"test",2);

select * from table1;
```


