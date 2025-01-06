CREATE SCHEMA IF NOT EXISTS GOLD;

use pacificretail_db.bronze;

select * from raw_customer;



execute task LOAD_CUSTOMER_DATA_TASK;

execute task LOAD_PRODUCT_DATA_TASK;
execute task LOAD_ORDER_DATA_TASK;

select * from raw_customer;

select * from raw_product;

select * from raw_order;

show streams;

select * from CUSTOMER_CHANGES_STREAM;

use pacificretail_db.silver;
show tasks;

execute task ORDER_SILVER_MERGE_TASK;
execute task PRODUCT_SILVER_MERGE_TASK;
execute task SILVER_CUSTOMER_MERGE_TASK;

select * from customer;

select * from product;

select * from orders;
