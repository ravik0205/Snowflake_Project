-- Create File format
CREATE OR REPLACE FILE FORMAT parquet_file_format
    TYPE = PARQUET
    COMPRESSION = AUTO
    BINARY_AS_TEXT = FALSE
    TRIM_SPACE = FALSE;


-- verify file format
SELECT 
    *
FROM @adls_stage/Order/
    (FILE_FORMAT => parquet_file_format)
LIMIT 10;




-- Create table
CREATE OR REPLACE TABLE raw_order (
  customer_id INT,
  payment_method STRING,
  product_id INT,
  quantity INT,
  store_type STRING,
  total_amount DOUBLE,
  transaction_date DATE,
  transaction_id STRING,
    source_file_name STRING,
    source_file_row_number INT,
    ingestion_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


--create task
CREATE OR REPLACE TASK load_order_data_task
    WAREHOUSE = compute_wh
    SCHEDULE = 'USING CRON 0 4 * * * America/New_York'
AS
    COPY INTO raw_order (
        customer_id,
        payment_method,
        product_id,
        quantity,
        store_type,
        total_amount,
        transaction_date,
        transaction_id,
        source_file_name,
        source_file_row_number
    )
    FROM (
        SELECT
            $1:customer_id::INT,
            $1:payment_method::STRING,
            $1:product_id::INT,
            $1:quantity::INT,
            $1:store_type::STRING,
            $1:total_amount::DOUBLE,
            $1:transaction_date::DATE,
            $1:transaction_id::STRING,
            METADATA$FILENAME,
            METADATA$FILE_ROW_NUMBER
        FROM @adls_stage/Order/
    )
    FILE_FORMAT = (FORMAT_NAME = 'parquet_file_format')
    ON_ERROR = 'CONTINUE'
    PATTERN = '.*[.]parquet';

-- start task
alter task load_order_data_task resume
