create schema silver;
use pacificretail_db.silver;

-- Silver Customer Table
CREATE TABLE IF NOT EXISTS SILVER.CUSTOMER (
    customer_id INT,
    name STRING,
    email STRING,
    country STRING,
    customer_type STRING,
    registration_date DATE,
	age INT,
    gender STRING,
    total_purchases INT,
    last_updated_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
	
CREATE TABLE IF NOT EXISTS SILVER.PRODUCT (
	   product_id INT,
		name STRING,
		category STRING,
		brand STRING,
		price FLOAT,
		stock_quantity INT,
		rating FLOAT,
		is_active BOOLEAN,
		last_updated_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
	);

CREATE TABLE IF NOT EXISTS SILVER.ORDERS (
    transaction_id STRING,
    customer_id INT,
    product_id INT,
    quantity INT,
    store_type STRING,
    total_amount DOUBLE,
    transaction_date DATE,
    payment_method STRING,
    last_updated_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

