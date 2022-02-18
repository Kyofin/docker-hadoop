SET execution.checkpointing.interval = 3s;



CREATE TABLE customers (
  id INT ,
  first_name STRING,
  last_name STRING,
  email STRING,
   PRIMARY KEY (id) NOT ENFORCED
)WITH (
    'connector' = 'mysql-cdc',
    'hostname' = 'localhost',
    'port' = '3306',
    'username' = 'root',
    'password' = '123456',
    'database-name' = 'inventory',
    'table-name' = 'customers'
  );


CREATE TABLE t_customers(
  id INT PRIMARY KEY NOT ENFORCED,
  first_name STRING,
  last_name STRING,
  email STRING

)
WITH (
  'connector' = 'hudi',
  'path' = '/flink/hudi/t_customers'
);

insert into t_customers select * from customers;


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

SET execution.checkpointing.interval = 3s;


insert into t_products select * from products;
