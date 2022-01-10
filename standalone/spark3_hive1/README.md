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
apache-hive-1.2.1-bin  entrypoint_hadoop.sh  jdk1.8.0_141      mysql80-community-release-el7-3.noarch.rpm  zookeeper-3.4.6
apache-maven-3.6.1     hadoop-2.7.3          kafka_2.11-1.1.1  spark-3.1.2-bin-hadoop2.7

[root@737e7d396e5b admin]# jps
352 NodeManager
147 NameNode
293 ResourceManager
2154 Jps
204 DataNode
414 JobHistoryServer
```

## 已知问题
使用spark-sql进入终端后，可以正常建hive表，删表。但是在第一次执行`insert into t1 values(1);`语句时，会出现下面错误，但是不影响数据插入。
```shell script
22/01/10 04:57:30 WARN session.SessionState: METASTORE_FILTER_HOOK will be ignored, since hive.security.authorization.manager is set to instance of HiveAuthorizerFactory.
22/01/10 04:57:31 WARN conf.HiveConf: HiveConf of name hive.stats.jdbc.timeout does not exist
22/01/10 04:57:31 WARN conf.HiveConf: HiveConf of name hive.stats.retries.wait does not exist
22/01/10 04:57:34 WARN DataNucleus.Query: Query for candidates of org.apache.hadoop.hive.metastore.model.MConstraint and subclasses resulted in no possible candidates
Required table missing : "`KEY_CONSTRAINTS`" in Catalog "" Schema "". DataNucleus requires this table to perform its persistence operations. Either your MetaData is incorrect, or you need to enable "datanucleus.schema.autoCreateTables"
org.datanucleus.store.rdbms.exceptions.MissingTableException: Required table missing : "`KEY_CONSTRAINTS`" in Catalog "" Schema "". DataNucleus requires this table to perform its persistence operations. Either your MetaData is incorrect, or you need to enable "datanucleus.schema.autoCreateTables"
	at org.datanucleus.store.rdbms.table.AbstractTable.exists(AbstractTable.java:606)
	at org.datanucleus.store.rdbms.RDBMSStoreManager$ClassAdder.performTablesValidation(RDBMSStoreManager.java:3385)
	at org.datanucleus.store.rdbms.RDBMSStoreManager$ClassAdder.run(RDBMSStoreManager.java:2896)
	at org.datanucleus.store.rdbms.AbstractSchemaTransaction.execute(AbstractSchemaTransaction.java:119)
	at org.datanucleus.store.rdbms.RDBMSStoreManager.manageClasses(RDBMSStoreManager.java:1627)
	at org.datanucleus.store.rdbms.RDBMSStoreManager.getDatastoreClass(RDBMSStoreManager.java:672)
	at org.datanucleus.store.rdbms.query.RDBMSQueryUtils.getStatementForCandidates(RDBMSQueryUtils.java:425)
	at org.datanucleus.store.rdbms.query.JDOQLQuery.compileQueryFull(JDOQLQuery.java:865)
	at org.datanucleus.store.rdbms.query.JDOQLQuery.compileInternal(JDOQLQuery.java:347)
	at org.datanucleus.store.query.Query.executeQuery(Query.java:1816)
	at org.datanucleus.store.query.Query.executeWithArray(Query.java:1744)
	at org.datanucleus.store.query.Query.execute(Query.java:1726)
	at org.datanucleus.api.jdo.JDOQuery.executeInternal(JDOQuery.java:374)
	at org.datanucleus.api.jdo.JDOQuery.execute(JDOQuery.java:216)
	at org.apache.hadoop.hive.metastore.MetaStoreDirectSql.ensureDbInit(MetaStoreDirectSql.java:190)
	at org.apache.hadoop.hive.metastore.MetaStoreDirectSql.<init>(MetaStoreDirectSql.java:144)
	at org.apache.hadoop.hive.metastore.ObjectStore.initializeHelper(ObjectStore.java:410)
	at org.apache.hadoop.hive.metastore.ObjectStore.initialize(ObjectStore.java:342)
	at org.apache.hadoop.hive.metastore.ObjectStore.setConf(ObjectStore.java:303)
	at org.apache.hadoop.util.ReflectionUtils.setConf(ReflectionUtils.java:76)
	at org.apache.hadoop.util.ReflectionUtils.newInstance(ReflectionUtils.java:136)
	at org.apache.hadoop.hive.metastore.RawStoreProxy.<init>(RawStoreProxy.java:58)
	at org.apache.hadoop.hive.metastore.RawStoreProxy.getProxy(RawStoreProxy.java:67)
	at org.apache.hadoop.hive.metastore.HiveMetaStore$HMSHandler.newRawStoreForConf(HiveMetaStore.java:628)
	at org.apache.hadoop.hive.metastore.HiveMetaStore$HMSHandler.getMSForConf(HiveMetaStore.java:594)
	at org.apache.hadoop.hive.metastore.HiveMetaStore$HMSHandler.getMS(HiveMetaStore.java:588)
	at org.apache.hadoop.hive.metastore.HiveMetaStore$HMSHandler.createDefaultDB(HiveMetaStore.java:655)
	at org.apache.hadoop.hive.metastore.HiveMetaStore$HMSHandler.init(HiveMetaStore.java:431)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.apache.hadoop.hive.metastore.RetryingHMSHandler.invokeInternal(RetryingHMSHandler.java:148)
	at org.apache.hadoop.hive.metastore.RetryingHMSHandler.invoke(RetryingHMSHandler.java:107)
	at org.apache.hadoop.hive.metastore.RetryingHMSHandler.<init>(RetryingHMSHandler.java:79)
	at org.apache.hadoop.hive.metastore.RetryingHMSHandler.getProxy(RetryingHMSHandler.java:92)
	at org.apache.hadoop.hive.metastore.HiveMetaStore.newRetryingHMSHandler(HiveMetaStore.java:6902)
	at org.apache.hadoop.hive.metastore.HiveMetaStoreClient.<init>(HiveMetaStoreClient.java:164)
	at org.apache.hadoop.hive.ql.metadata.SessionHiveMetaStoreClient.<init>(SessionHiveMetaStoreClient.java:70)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
	at org.apache.hadoop.hive.metastore.MetaStoreUtils.newInstance(MetaStoreUtils.java:1707)
	at org.apache.hadoop.hive.metastore.RetryingMetaStoreClient.<init>(RetryingMetaStoreClient.java:83)
	at org.apache.hadoop.hive.metastore.RetryingMetaStoreClient.getProxy(RetryingMetaStoreClient.java:133)
	at org.apache.hadoop.hive.metastore.RetryingMetaStoreClient.getProxy(RetryingMetaStoreClient.java:104)
	at org.apache.hadoop.hive.ql.metadata.Hive.createMetaStoreClient(Hive.java:3600)
	at org.apache.hadoop.hive.ql.metadata.Hive.getMSC(Hive.java:3652)
	at org.apache.hadoop.hive.ql.metadata.Hive.getMSC(Hive.java:3632)
	at org.apache.hadoop.hive.ql.metadata.Hive.getAllFunctions(Hive.java:3894)
	at org.apache.hadoop.hive.ql.metadata.Hive.reloadFunctions(Hive.java:248)
	at org.apache.hadoop.hive.ql.metadata.Hive.registerAllFunctionsOnce(Hive.java:231)
	at org.apache.hadoop.hive.ql.metadata.Hive.<init>(Hive.java:388)
	at org.apache.hadoop.hive.ql.metadata.Hive.create(Hive.java:332)
	at org.apache.hadoop.hive.ql.metadata.Hive.getInternal(Hive.java:312)
	at org.apache.hadoop.hive.ql.metadata.Hive.get(Hive.java:288)
	at org.apache.hadoop.hive.ql.session.SessionState.setAuthorizerV2Config(SessionState.java:917)
	at org.apache.hadoop.hive.ql.session.SessionState.setupAuth(SessionState.java:881)
	at org.apache.hadoop.hive.ql.session.SessionState.getAuthenticator(SessionState.java:1483)
	at org.apache.hadoop.hive.ql.session.SessionState.getUserFromAuthenticator(SessionState.java:1154)
	at org.apache.hadoop.hive.ql.metadata.Table.getEmptyTable(Table.java:180)
	at org.apache.hadoop.hive.ql.metadata.Table.<init>(Table.java:122)
	at org.apache.spark.sql.hive.client.HiveClientImpl$.toHiveTable(HiveClientImpl.scala:1045)
	at org.apache.spark.sql.hive.execution.InsertIntoHiveTable.run(InsertIntoHiveTable.scala:88)
	at org.apache.spark.sql.execution.command.DataWritingCommandExec.sideEffectResult$lzycompute(commands.scala:108)
	at org.apache.spark.sql.execution.command.DataWritingCommandExec.sideEffectResult(commands.scala:106)
	at org.apache.spark.sql.execution.command.DataWritingCommandExec.executeCollect(commands.scala:120)
	at org.apache.spark.sql.Dataset.$anonfun$logicalPlan$1(Dataset.scala:228)
	at org.apache.spark.sql.Dataset.$anonfun$withAction$1(Dataset.scala:3687)
	at org.apache.spark.sql.execution.SQLExecution$.$anonfun$withNewExecutionId$5(SQLExecution.scala:103)
	at org.apache.spark.sql.execution.SQLExecution$.withSQLConfPropagated(SQLExecution.scala:163)
	at org.apache.spark.sql.execution.SQLExecution$.$anonfun$withNewExecutionId$1(SQLExecution.scala:90)
	at org.apache.spark.sql.SparkSession.withActive(SparkSession.scala:775)
	at org.apache.spark.sql.execution.SQLExecution$.withNewExecutionId(SQLExecution.scala:64)
	at org.apache.spark.sql.Dataset.withAction(Dataset.scala:3685)
	at org.apache.spark.sql.Dataset.<init>(Dataset.scala:228)
	at org.apache.spark.sql.Dataset$.$anonfun$ofRows$2(Dataset.scala:99)
	at org.apache.spark.sql.SparkSession.withActive(SparkSession.scala:775)
	at org.apache.spark.sql.Dataset$.ofRows(Dataset.scala:96)
	at org.apache.spark.sql.SparkSession.$anonfun$sql$1(SparkSession.scala:618)
	at org.apache.spark.sql.SparkSession.withActive(SparkSession.scala:775)
	at org.apache.spark.sql.SparkSession.sql(SparkSession.scala:613)
	at org.apache.spark.sql.SQLContext.sql(SQLContext.scala:650)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLDriver.run(SparkSQLDriver.scala:67)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLCLIDriver.processCmd(SparkSQLCLIDriver.scala:381)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLCLIDriver.$anonfun$processLine$1(SparkSQLCLIDriver.scala:500)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLCLIDriver.$anonfun$processLine$1$adapted(SparkSQLCLIDriver.scala:494)
	at scala.collection.Iterator.foreach(Iterator.scala:941)
	at scala.collection.Iterator.foreach$(Iterator.scala:941)
	at scala.collection.AbstractIterator.foreach(Iterator.scala:1429)
	at scala.collection.IterableLike.foreach(IterableLike.scala:74)
	at scala.collection.IterableLike.foreach$(IterableLike.scala:73)
	at scala.collection.AbstractIterable.foreach(Iterable.scala:56)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLCLIDriver.processLine(SparkSQLCLIDriver.scala:494)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLCLIDriver$.main(SparkSQLCLIDriver.scala:284)
	at org.apache.spark.sql.hive.thriftserver.SparkSQLCLIDriver.main(SparkSQLCLIDriver.scala)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.apache.spark.deploy.JavaMainApplication.start(SparkApplication.scala:52)
	at org.apache.spark.deploy.SparkSubmit.org$apache$spark$deploy$SparkSubmit$$runMain(SparkSubmit.scala:951)
	at org.apache.spark.deploy.SparkSubmit.doRunMain$1(SparkSubmit.scala:180)
	at org.apache.spark.deploy.SparkSubmit.submit(SparkSubmit.scala:203)
	at org.apache.spark.deploy.SparkSubmit.doSubmit(SparkSubmit.scala:90)
	at org.apache.spark.deploy.SparkSubmit$$anon$2.doSubmit(SparkSubmit.scala:1039)
	at org.apache.spark.deploy.SparkSubmit$.main(SparkSubmit.scala:1048)
	at org.apache.spark.deploy.SparkSubmit.main(SparkSubmit.scala)
22/01/10 04:57:34 ERROR metastore.ObjectStore: Version information found in metastore differs 1.2.0 from expected schema version 2.3.0. Schema verififcation is disabled hive.metastore.schema.verification
22/01/10 04:57:34 WARN metastore.ObjectStore: setMetaStoreSchemaVersion called but recording version is disabled: version = 2.3.0, comment = Set by MetaStore UNKNOWN@172.17.0.5
22/01/10 04:57:40 ERROR hdfs.KeyProviderCache: Could not find uri with key [dfs.encryption.key.provider.uri] to create a keyProvider !!
22/01/10 04:57:40 WARN metastore.ObjectStore: Failed to get database global_temp, returning NoSuchObjectException
Time taken: 11.341 seconds
```
