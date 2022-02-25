CREATE CATALOG hadoop_catalog WITH (
  'type'='iceberg',
  'catalog-type'='hadoop',
  'warehouse'='hdfs:///iceberg/warehouse/path',
  'property-version'='1'
);

CREATE TABLE products (
  id INT ,
  name STRING,
  description STRING,
  weight float,
   PRIMARY KEY (id) NOT ENFORCED
)WITH (
    'connector' = 'mysql-cdc',
    'hostname' = 'localhost',
    'port' = '3306',
    'username' = 'root',
    'password' = '123456',
    'database-name' = 'inventory',
    'table-name' = 'products'
  );


CREATE TABLE `hadoop_catalog`.`default`.`t_products`(
 id INT ,
  name STRING,
  description STRING,
  weight float,
  PRIMARY KEY (id) NOT ENFORCED
)WITH (
    'format-version' = '2'                          -- iceberg表版本，可选1，2
   , 'write.upsert.enabled' = 'true'                 -- 开启upsert
);


SET execution.checkpointing.interval = 3s;


insert into `hadoop_catalog`.`default`.`t_products` select * from products;

