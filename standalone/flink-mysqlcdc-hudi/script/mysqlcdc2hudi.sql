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
